var restoreMatrix = function(rowSum, colSum) {
    const m = rowSum.length;
    const n = colSum.length;
    const matrix = Array(m).fill(null).map(() => Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            matrix[i][j] = Math.min(rowSum[i], colSum[j]);
            rowSum[i] -= matrix[i][j];
            colSum[j] -= matrix[i][j];
        }
    }

    return matrix;
};