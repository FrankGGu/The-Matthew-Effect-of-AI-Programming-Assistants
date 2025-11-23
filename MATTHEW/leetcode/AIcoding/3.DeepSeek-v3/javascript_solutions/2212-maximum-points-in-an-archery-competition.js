var maximumBobPoints = function(numArrows, aliceArrows) {
    let maxPoints = 0;
    let bestConfig = new Array(12).fill(0);

    function backtrack(index, remainingArrows, currentPoints, currentConfig) {
        if (index === 12) {
            if (currentPoints > maxPoints) {
                maxPoints = currentPoints;
                bestConfig = [...currentConfig];
                if (remainingArrows > 0) {
                    bestConfig[11] += remainingArrows;
                }
            }
            return;
        }

        // Option 1: Do not win this section
        backtrack(index + 1, remainingArrows, currentPoints, currentConfig);

        // Option 2: Win this section
        const arrowsNeeded = aliceArrows[index] + 1;
        if (remainingArrows >= arrowsNeeded) {
            currentConfig[index] = arrowsNeeded;
            backtrack(index + 1, remainingArrows - arrowsNeeded, currentPoints + index, currentConfig);
            currentConfig[index] = 0;
        }
    }

    backtrack(0, numArrows, 0, new Array(12).fill(0));
    return bestConfig;
};