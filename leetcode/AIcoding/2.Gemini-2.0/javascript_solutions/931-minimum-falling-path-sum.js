var minFallingPathSum = function(matrix) {
    const n = matrix.length;
    for (let i = 1; i < n; i++) {
        for (let j = 0; j < n; j++) {
            let min = matrix[i - 1][j];
            if (j > 0) {
                min = Math.min(min, matrix[i - 1][j - 1]);
            }
            if (j < n - 1) {
                min = Math.min(min, matrix[i - 1][j + 1]);
            }
            matrix[i][j] += min;
        }
    }
    let minSum = matrix[n - 1][0];
    for (let i = 1; i < n; i++) {
        minSum = Math.min(minSum, matrix[n - 1][i]);
    }
    return minSum;
};