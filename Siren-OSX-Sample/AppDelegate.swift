//
//  AppDelegate.swift
//  Siren-OSX-Sample
//
//  Created by Dong Wu on 01/12/2016.
//  Copyright © 2016 Dong Wu. All rights reserved.
//

import Cocoa
import Siren

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        setupSiren()
    }
    
    
    func setupSiren() {
        
        let siren = Siren.sharedInstance
        
        // Optional
        siren.delegate = self
        
        // Optional
        siren.debugEnabled = true
        
        // Optional - Defaults to .Option
        //        siren.alertType = .Option // or .Force, .Skip, .None
        
        // Optional - Can set differentiated Alerts for Major, Minor, Patch, and Revision Updates (Must be called AFTER siren.alertType, if you are using siren.alertType)
        siren.majorUpdateAlertType = .option
        siren.minorUpdateAlertType = .option
        siren.patchUpdateAlertType = .option
        siren.revisionUpdateAlertType = .option
        
        // Optional - Sets all messages to appear in Spanish. Siren supports many other languages, not just English and Russian.
        //        siren.forceLanguageLocalization = .Russian
        
        // Optional - Set this variable if your app is not available in the U.S. App Store. List of codes: https://developer.apple.com/library/content/documentation/LanguagesUtilities/Conceptual/iTunesConnect_Guide/Appendices/AppStoreTerritories.html
        //        siren.countryCode = ""
        
        // Optional - Set this variable if you would only like to show an alert if your app has been available on the store for a few days. The number 5 is used as an example.
        //        siren.showAlertAfterCurrentVersionHasBeenReleasedForDays = 5
        
        // Required
        siren.checkVersion(checkType: .immediately)
    }

    func applicationDidBecomeActive(_ notification: Notification) {
        Siren.sharedInstance.checkVersion(checkType: .daily)
    }

    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}


extension AppDelegate: SirenDelegate
{
    func sirenDidShowUpdateDialog(alertType: SirenAlertType) {
        print(#function, alertType)
    }
    
    func sirenUserDidCancel() {
        print(#function)
    }
    
    func sirenUserDidSkipVersion() {
        print(#function)
    }
    
    func sirenUserDidLaunchAppStore() {
        print(#function)
    }
    
    func sirenDidFailVersionCheck(error: NSError) {
        print(#function, error)
    }
    
    func sirenLatestVersionInstalled() {
        print(#function, "Latest version of app is installed")
    }
    
    /**
     This delegate method is only hit when alertType is initialized to .None
     */
    func sirenDidDetectNewVersionWithoutAlert(message: String) {
        print(#function, "\(message)")
    }
}


