var minCostSetTime = function(startAt, moveCost, pushCost, targetSeconds) {
    let minCost = Infinity;

    for (let minutes = 0; minutes <= 99; minutes++) {
        let seconds = targetSeconds - minutes * 60;

        if (seconds >= 0 && seconds <= 99) {
            let timeStr = String(minutes).padStart(2, '0') + String(seconds).padStart(2, '0');
            if (minutes === 100) continue;

            let cost = 0;
            let currentDigit = String(startAt);
            let firstNonZeroIndex = 0;

            while (firstNonZeroIndex < timeStr.length && timeStr[firstNonZeroIndex] === '0') {
                firstNonZeroIndex++;
            }

            if (firstNonZeroIndex === timeStr.length) {
                timeStr = '0';
            } else {
                timeStr = timeStr.substring(firstNonZeroIndex);
            }

            for (let i = 0; i < timeStr.length; i++) {
                if (timeStr[i] !== currentDigit) {
                    cost += moveCost;
                    currentDigit = timeStr[i];
                }
                cost += pushCost;
            }

            minCost = Math.min(minCost, cost);
        }
    }

    return minCost;
};