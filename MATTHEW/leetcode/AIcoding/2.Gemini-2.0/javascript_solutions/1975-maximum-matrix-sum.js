var maxMatrixSum = function(matrix) {
    let negCount = 0;
    let sum = 0;
    let minAbs = Infinity;

    for (let i = 0; i < matrix.length; i++) {
        for (let j = 0; j < matrix[0].length; j++) {
            if (matrix[i][j] < 0) {
                negCount++;
            }
            sum += Math.abs(matrix[i][j]);
            minAbs = Math.min(minAbs, Math.abs(matrix[i][j]));
        }
    }

    if (negCount % 2 === 0) {
        return sum;
    } else {
        return sum - 2 * minAbs;
    }
};