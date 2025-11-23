var minFallingPathSum = function(matrix) {
    const n = matrix.length;
    for (let i = n - 2; i >= 0; i--) {
        for (let j = 0; j < n; j++) {
            let min = Infinity;
            for (let k = 0; k < n; k++) {
                if (k !== j) {
                    min = Math.min(min, matrix[i + 1][k]);
                }
            }
            matrix[i][j] += min;
        }
    }
    return Math.min(...matrix[0]);
};