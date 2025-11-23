var maxMatrixSum = function(matrix) {
    let sum = 0;
    let minAbs = Infinity;
    let negativeCount = 0;

    for (let i = 0; i < matrix.length; i++) {
        for (let j = 0; j < matrix[0].length; j++) {
            const num = matrix[i][j];
            sum += Math.abs(num);
            minAbs = Math.min(minAbs, Math.abs(num));
            if (num < 0) {
                negativeCount++;
            }
        }
    }

    if (negativeCount % 2 === 0) {
        return sum;
    } else {
        return sum - 2 * minAbs;
    }
};