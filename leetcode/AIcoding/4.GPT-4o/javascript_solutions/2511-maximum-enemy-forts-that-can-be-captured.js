var captureForts = function(forts) {
    let maxCapture = 0;
    let currentCapture = 0;
    let foundEnemy = false;

    for (let fort of forts) {
        if (fort === 1) {
            foundEnemy = true;
            maxCapture = Math.max(maxCapture, currentCapture);
            currentCapture = 0;
        } else if (fort === -1) {
            if (foundEnemy) {
                maxCapture = Math.max(maxCapture, currentCapture);
            }
            currentCapture = 0;
            foundEnemy = false;
        } else {
            currentCapture++;
        }
    }

    return maxCapture;
};