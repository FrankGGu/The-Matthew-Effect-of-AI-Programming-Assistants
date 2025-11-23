var maxMatrixSum = function(matrix) {
    let totalAbsSum = 0;
    let negCount = 0;
    let minAbsVal = Infinity;

    for (let r = 0; r < matrix.length; r++) {
        for (let c = 0; c < matrix[0].length; c++) {
            const val = matrix[r][c];
            if (val < 0) {
                negCount++;
            }
            totalAbsSum += Math.abs(val);
            minAbsVal = Math.min(minAbsVal, Math.abs(val));
        }
    }

    if (negCount % 2 === 0) {
        return totalAbsSum;
    } else {
        return totalAbsSum - 2 * minAbsVal;
    }
};