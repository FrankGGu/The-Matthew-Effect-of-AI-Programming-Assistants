var restoreMatrix = function(rowSum, colSum) {
    const m = rowSum.length;
    const n = colSum.length;
    const matrix = new Array(m).fill().map(() => new Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const min = Math.min(rowSum[i], colSum[j]);
            matrix[i][j] = min;
            rowSum[i] -= min;
            colSum[j] -= min;
        }
    }

    return matrix;
};