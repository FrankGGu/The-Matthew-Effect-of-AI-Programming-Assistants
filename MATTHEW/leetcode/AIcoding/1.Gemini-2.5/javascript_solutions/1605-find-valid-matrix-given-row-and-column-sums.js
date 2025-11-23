var restoreMatrix = function(rowSum, colSum) {
    const m = rowSum.length;
    const n = colSum.length;
    const resultMatrix = Array(m).fill(0).map(() => Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const value = Math.min(rowSum[i], colSum[j]);
            resultMatrix[i][j] = value;
            rowSum[i] -= value;
            colSum[j] -= value;
        }
    }

    return resultMatrix;
};