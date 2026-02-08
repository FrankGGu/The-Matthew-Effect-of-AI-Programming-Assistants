var soupServings = function(n) {
    if (n > 4800) return 1;
    const m = Math.ceil(n / 25);
    const dp = Array(m + 1).fill(null).map(() => Array(m + 1).fill(0));
    dp[0][0] = 0.5;
    for (let i = 1; i <= m; i++) {
        dp[0][i] = 1;
    }

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= m; j++) {
            dp[i][j] = 0.25 * (dp[Math.max(0, i - 4)][j] + dp[Math.max(0, i - 3)][Math.max(0, j - 1)] +
                               dp[Math.max(0, i - 2)][Math.max(0, j - 2)] + dp[Math.max(0, i - 1)][Math.max(0, j - 3)]);
        }
    }

    return dp[m][m];
};