var matrixBlockSum = function(mat, K) {
    const m = mat.length, n = mat[0].length;
    const prefixSum = Array.from({ length: m + 1 }, () => Array(n + 1).fill(0));

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            prefixSum[i][j] = mat[i - 1][j - 1] + prefixSum[i - 1][j] + prefixSum[i][j - 1] - prefixSum[i - 1][j - 1];
        }
    }

    const result = Array.from({ length: m }, () => Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const r1 = Math.max(0, i - K);
            const r2 = Math.min(m - 1, i + K);
            const c1 = Math.max(0, j - K);
            const c2 = Math.min(n - 1, j + K);
            result[i][j] = prefixSum[r2 + 1][c2 + 1] - prefixSum[r1][c2 + 1] - prefixSum[r2 + 1][c1] + prefixSum[r1][c1];
        }
    }

    return result;
};