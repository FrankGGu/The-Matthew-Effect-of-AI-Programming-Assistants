var maxSideLength = function(mat, threshold) {
    const m = mat.length;
    const n = mat[0].length;
    const prefixSum = Array.from({ length: m + 1 }, () => new Array(n + 1).fill(0));

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            prefixSum[i][j] = mat[i - 1][j - 1] + prefixSum[i - 1][j] + prefixSum[i][j - 1] - prefixSum[i - 1][j - 1];
        }
    }

    let maxLen = 0;
    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            for (let k = maxLen + 1; k <= Math.min(m, n); k++) {
                if (i - k < 0 || j - k < 0) break;
                const sum = prefixSum[i][j] - prefixSum[i - k][j] - prefixSum[i][j - k] + prefixSum[i - k][j - k];
                if (sum <= threshold) {
                    maxLen = k;
                } else {
                    break;
                }
            }
        }
    }

    return maxLen;
};