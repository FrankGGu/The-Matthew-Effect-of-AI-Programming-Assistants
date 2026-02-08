var maxSideLength = function(mat, threshold) {
    const m = mat.length;
    const n = mat[0].length;
    const prefixSum = Array(m + 1).fill(null).map(() => Array(n + 1).fill(0));

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            prefixSum[i][j] = prefixSum[i - 1][j] + prefixSum[i][j - 1] - prefixSum[i - 1][j - 1] + mat[i - 1][j - 1];
        }
    }

    let maxLen = 0;
    for (let k = 1; k <= Math.min(m, n); k++) {
        let found = false;
        for (let i = k; i <= m; i++) {
            for (let j = k; j <= n; j++) {
                const sum = prefixSum[i][j] - prefixSum[i - k][j] - prefixSum[i][j - k] + prefixSum[i - k][j - k];
                if (sum <= threshold) {
                    maxLen = k;
                    found = true;
                    break;
                }
            }
            if (found) break;
        }
        if (!found) break;
    }

    return maxLen;
};