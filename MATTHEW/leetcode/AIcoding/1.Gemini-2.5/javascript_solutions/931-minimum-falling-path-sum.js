var minFallingPathSum = function(matrix) {
    const n = matrix.length;

    for (let i = 1; i < n; i++) {
        for (let j = 0; j < n; j++) {
            let minPrevRowSum = Infinity;

            if (j > 0) {
                minPrevRowSum = Math.min(minPrevRowSum, matrix[i - 1][j - 1]);
            }
            minPrevRowSum = Math.min(minPrevRowSum, matrix[i - 1][j]);
            if (j < n - 1) {
                minPrevRowSum = Math.min(minPrevRowSum, matrix[i - 1][j + 1]);
            }

            matrix[i][j] += minPrevRowSum;
        }
    }

    let minSum = Infinity;
    for (let j = 0; j < n; j++) {
        minSum = Math.min(minSum, matrix[n - 1][j]);
    }

    return minSum;
};