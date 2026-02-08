var minimizeTheDifference = function(mat, target) {
    const m = mat.length;
    const n = mat[0].length;
    let possibleSums = new Set();
    possibleSums.add(0);

    for (let i = 0; i < m; i++) {
        const newPossibleSums = new Set();
        for (const sum of possibleSums) {
            for (let j = 0; j < n; j++) {
                newPossibleSums.add(sum + mat[i][j]);
            }
        }
        possibleSums = newPossibleSums;
    }

    let minDiff = Infinity;
    for (const sum of possibleSums) {
        minDiff = Math.min(minDiff, Math.abs(sum - target));
    }

    return minDiff;
};