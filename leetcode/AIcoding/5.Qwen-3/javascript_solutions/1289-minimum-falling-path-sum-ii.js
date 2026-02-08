function minFallingPathSum(matrix) {
    const n = matrix.length;
    for (let i = 1; i < n; i++) {
        for (let j = 0; j < n; j++) {
            let minVal = Infinity;
            for (let k = 0; k < n; k++) {
                if (k !== j) {
                    minVal = Math.min(minVal, matrix[i - 1][k]);
                }
            }
            matrix[i][j] += minVal;
        }
    }
    return Math.min(...matrix[n - 1]);
}