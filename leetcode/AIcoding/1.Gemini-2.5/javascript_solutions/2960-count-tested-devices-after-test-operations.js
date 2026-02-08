var countTestedDevices = function(batteryPercentages) {
    let testedCount = 0;
    for (let i = 0; i < batteryPercentages.length; i++) {
        if (batteryPercentages[i] - testedCount > 0) {
            testedCount++;
        }
    }
    return testedCount;
};