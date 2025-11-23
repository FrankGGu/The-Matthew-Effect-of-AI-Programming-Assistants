function restoreMatrix(rowSum, colSum) {
    const m = rowSum.length, n = colSum.length;
    const result = Array.from({ length: m }, () => Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const value = Math.min(rowSum[i], colSum[j]);
            result[i][j] = value;
            rowSum[i] -= value;
            colSum[j] -= value;
        }
    }

    return result;
}