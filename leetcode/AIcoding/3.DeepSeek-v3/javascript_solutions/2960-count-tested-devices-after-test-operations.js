var countTestedDevices = function(batteryPercentages) {
    let count = 0;
    for (let i = 0; i < batteryPercentages.length; i++) {
        if (batteryPercentages[i] > 0) {
            count++;
            for (let j = i + 1; j < batteryPercentages.length; j++) {
                batteryPercentages[j] = Math.max(batteryPercentages[j] - 1, 0);
            }
        }
    }
    return count;
};