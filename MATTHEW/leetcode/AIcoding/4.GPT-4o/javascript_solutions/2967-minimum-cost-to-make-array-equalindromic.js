function minCost(s) {
    const n = s.length;
    const dp = Array.from({ length: n + 1 }, () => Array(n + 1).fill(0));

    for (let length = 2; length <= n; length++) {
        for (let i = 0; i <= n - length; i++) {
            const j = i + length - 1;
            if (s[i] === s[j]) {
                dp[i][j] = dp[i + 1][j - 1];
            } else {
                dp[i][j] = Math.min(dp[i + 1][j] + 1, dp[i][j - 1] + 1);
            }
        }
    }
    return dp[0][n - 1];
}