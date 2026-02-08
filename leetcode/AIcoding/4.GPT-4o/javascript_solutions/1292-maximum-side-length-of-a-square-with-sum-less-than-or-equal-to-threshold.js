var maxSideLength = function(mat, threshold) {
    const m = mat.length, n = mat[0].length;
    const prefixSum = Array.from({ length: m + 1 }, () => Array(n + 1).fill(0));

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            prefixSum[i][j] = mat[i - 1][j - 1] + prefixSum[i - 1][j] + prefixSum[i][j - 1] - prefixSum[i - 1][j - 1];
        }
    }

    let maxLength = 0;

    for (let length = 1; length <= Math.min(m, n); length++) {
        for (let i = length; i <= m; i++) {
            for (let j = length; j <= n; j++) {
                const sum = prefixSum[i][j] - prefixSum[i - length][j] - prefixSum[i][j - length] + prefixSum[i - length][j - length];
                if (sum <= threshold) {
                    maxLength = length;
                }
            }
        }
    }

    return maxLength;
};