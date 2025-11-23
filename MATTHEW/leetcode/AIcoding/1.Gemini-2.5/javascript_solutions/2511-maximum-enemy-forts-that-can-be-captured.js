var maximumEnemyForts = function(forts) {
    let maxCaptured = 0;
    let lastFortType = 0; // 0: no fort seen yet or current segment starts with 0s, 1: friendly fort, -1: enemy fort
    let currentCaptured = 0;

    for (let i = 0; i < forts.length; i++) {
        if (forts[i] === 0) {
            currentCaptured++;
        } else { // forts[i] is either 1 or -1
            if (lastFortType !== 0 && lastFortType !== forts[i]) {
                maxCaptured = Math.max(maxCaptured, currentCaptured);
            }
            currentCaptured = 0;
            lastFortType = forts[i];
        }
    }

    return maxCaptured;
};