function maxMatrixSum(matrix) {
    let totalSum = 0;
    let minElement = Infinity;
    let negativeCount = 0;

    for (let i = 0; i < matrix.length; i++) {
        for (let j = 0; j < matrix[i].length; j++) {
            totalSum += Math.abs(matrix[i][j]);
            if (matrix[i][j] < 0) negativeCount++;
            minElement = Math.min(minElement, Math.abs(matrix[i][j]));
        }
    }

    if (negativeCount % 2 === 0) {
        return totalSum;
    } else {
        return totalSum - 2 * minElement;
    }
}