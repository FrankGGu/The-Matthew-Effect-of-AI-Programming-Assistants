function maxMatrixSum(matrix) {
    let minAbs = Infinity;
    let total = 0;
    let negativeCount = 0;

    for (let i = 0; i < matrix.length; i++) {
        for (let j = 0; j < matrix[i].length; j++) {
            const val = matrix[i][j];
            if (val < 0) {
                negativeCount++;
                total += -val;
                minAbs = Math.min(minAbs, -val);
            } else {
                total += val;
                minAbs = Math.min(minAbs, val);
            }
        }
    }

    if (negativeCount % 2 === 0) {
        return total;
    } else {
        return total - 2 * minAbs;
    }
}