var minNumberOfFrogs = function(croakOfFrogs) {
    let cCount = 0;
    let rCount = 0;
    let oCount = 0;
    let aCount = 0;
    let kCount = 0;

    let currentFrogs = 0;
    let maxFrogs = 0;

    for (let i = 0; i < croakOfFrogs.length; i++) {
        let char = croakOfFrogs[i];

        if (char === 'c') {
            cCount++;
            currentFrogs++;
            maxFrogs = Math.max(maxFrogs, currentFrogs);
        } else if (char === 'r') {
            rCount++;
        } else if (char === 'o') {
            oCount++;
        } else if (char === 'a') {
            aCount++;
        } else if (char === 'k') {
            kCount++;
            currentFrogs--;
        }

        if (rCount > cCount || oCount > rCount || aCount > oCount || kCount > aCount) {
            return -1;
        }
    }

    if (cCount === rCount && rCount === oCount && oCount === aCount && aCount === kCount) {
        return maxFrogs;
    } else {
        return -1;
    }
};