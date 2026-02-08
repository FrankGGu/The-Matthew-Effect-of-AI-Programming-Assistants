var maxSizeSlices = function(slices, k) {
    const n = slices.length;
    const dp = Array.from({ length: k + 1 }, () => Array(n + 1).fill(0));

    for (let i = 1; i <= k; i++) {
        for (let j = 1; j <= n; j++) {
            dp[i][j] = dp[i][j - 1];
            if (j >= 2 * k) {
                dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - 2] + slices[j - 1]);
            }
            if (j >= 1) {
                dp[i][j] = Math.max(dp[i][j], dp[i][j - 1]);
            }
        }
    }

    return dp[k][n];
};