var minFallingPathSum = function(matrix) {
    const n = matrix.length;
    for (let i = n - 2; i >= 0; i--) {
        for (let j = 0; j < n; j++) {
            let minBelow = matrix[i + 1][j];
            if (j > 0) minBelow = Math.min(minBelow, matrix[i + 1][j - 1]);
            if (j < n - 1) minBelow = Math.min(minBelow, matrix[i + 1][j + 1]);
            matrix[i][j] += minBelow;
        }
    }
    return Math.min(...matrix[0]);
};