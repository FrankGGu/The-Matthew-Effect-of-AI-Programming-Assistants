var matrixBlockSum = function(mat, k) {
    const m = mat.length;
    const n = mat[0].length;

    const prefixSum = Array(m + 1).fill(0).map(() => Array(n + 1).fill(0));

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            prefixSum[r + 1][c + 1] = mat[r][c] + prefixSum[r][c + 1] + prefixSum[r + 1][c] - prefixSum[r][c];
        }
    }

    const answer = Array(m).fill(0).map(() => Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const r1 = Math.max(0, i - k);
            const c1 = Math.max(0, j - k);
            const r2 = Math.min(m - 1, i + k);
            const c2 = Math.min(n - 1, j + k);

            answer[i][j] = prefixSum[r2 + 1][c2 + 1] - prefixSum[r1][c2 + 1] - prefixSum[r2 + 1][c1] + prefixSum[r1][c1];
        }
    }

    return answer;
};