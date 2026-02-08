var minCostSetTime = function(startAt, moveCost, pushCost, targetSeconds) {
    let minTotalCost = Infinity;

    const calculateCost = (m, s) => {
        let currentCost = 0;
        let currentDigit = startAt;

        const mmStr = m.toString().padStart(2, '0');
        const ssStr = s.toString().padStart(2, '0');
        let fullStr = mmStr + ssStr;

        let digitsToPushStr = fullStr.replace(/^0+/, '');

        if (digitsToPushStr === '') {
            digitsToPushStr = '0';
        }

        for (let i = 0; i < digitsToPushStr.length; i++) {
            const digit = parseInt(digitsToPushStr[i]);
            if (digit !== currentDigit) {
                currentCost += moveCost;
            }
            currentCost += pushCost;
            currentDigit = digit;
        }
        return currentCost;
    };

    // Option 1: Direct M:S representation
    // M = floor(targetSeconds / 60)
    // S = targetSeconds % 60
    let m1 = Math.floor(targetSeconds / 60);
    let s1 = targetSeconds % 60;

    // Check if this (m1, s1) is a valid MM:SS combination (M <= 99, S <= 99)
    // s1 is always <= 59, so s1 <= 99 is guaranteed. We only need to check m1.
    if (m1 <= 99) {
        minTotalCost = Math.min(minTotalCost, calculateCost(m1, s1));
    }

    // Option 2: (M-1):(S+60) representation
    // This is valid if:
    // 1. M-1 >= 0 (i.e., m1 >= 1)
    // 2. M-1 <= 99 (i.e., m1 <= 100)
    // 3. S+60 <= 99 (i.e., s1 <= 39)
    if (m1 >= 1 && m1 <= 100 && s1 <= 39) {
        let m2 = m1 - 1;
        let s2 = s1 + 60;
        minTotalCost = Math.min(minTotalCost, calculateCost(m2, s2));
    }

    return minTotalCost;
};