var maximumBobPoints = function(numArrows, aliceArrows) {
    let maxScore = -1;
    let bestBobArrows = new Array(12).fill(0);

    function backtrack(section, currentArrowsUsed, currentScore, currentBobArrows) {
        if (section < 0) {
            if (currentScore > maxScore) {
                maxScore = currentScore;
                bestBobArrows = [...currentBobArrows];
                bestBobArrows[0] += numArrows - currentArrowsUsed;
            }
            return;
        }

        // Option 1: Bob does NOT try to win this section
        currentBobArrows[section] = 0;
        backtrack(section - 1, currentArrowsUsed, currentScore, currentBobArrows);

        // Option 2: Bob TRIES to win this section
        const arrowsNeededToWin = aliceArrows[section] + 1;

        if (currentArrowsUsed + arrowsNeededToWin <= numArrows) {
            currentBobArrows[section] = arrowsNeededToWin;
            backtrack(section - 1, currentArrowsUsed + arrowsNeededToWin, currentScore + section, currentBobArrows);
        }
    }

    backtrack(11, 0, 0, new Array(12).fill(0));

    return bestBobArrows;
};