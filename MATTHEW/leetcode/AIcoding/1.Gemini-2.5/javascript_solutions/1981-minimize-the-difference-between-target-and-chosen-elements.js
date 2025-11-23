var minimizeTheDifference = function(mat, target) {
    let possibleSums = new Set([0]);

    for (let i = 0; i < mat.length; i++) {
        let currentRow = mat[i];
        let nextPossibleSums = new Set();

        for (let currentSum of possibleSums) {
            for (let num of currentRow) {
                nextPossibleSums.add(currentSum + num);
            }
        }
        possibleSums = nextPossibleSums;
    }

    let minDiff = Infinity;
    for (let sum of possibleSums) {
        minDiff = Math.min(minDiff, Math.abs(sum - target));
    }

    return minDiff;
};