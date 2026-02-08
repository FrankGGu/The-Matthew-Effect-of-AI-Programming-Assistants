var maxPoints = function(numArrows, arrows) {
    let maxScore = 0;
    let bestCombination = new Array(12).fill(0);

    const backtrack = (index, arrowsLeft, score, currentCombination) => {
        if (index === 12 || arrowsLeft <= 0) {
            if (score > maxScore) {
                maxScore = score;
                bestCombination = [...currentCombination];
            }
            return;
        }

        if (arrowsLeft > arrows[index]) {
            currentCombination[index] = arrows[index] + 1;
            backtrack(index + 1, arrowsLeft - currentCombination[index], score + index, currentCombination);
            currentCombination[index] = 0;
        }

        backtrack(index + 1, arrowsLeft, score, currentCombination);
    };

    backtrack(0, numArrows, 0, new Array(12).fill(0));
    bestCombination[11] = numArrows - bestCombination.slice(0, 11).reduce((a, b) => a + b, 0);
    return bestCombination;
};