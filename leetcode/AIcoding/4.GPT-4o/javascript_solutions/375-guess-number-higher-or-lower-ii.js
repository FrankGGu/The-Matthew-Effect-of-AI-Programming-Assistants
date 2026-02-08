var getMoneyAmount = function(n) {
    const dp = Array.from({ length: n + 1 }, () => Array(n + 1).fill(0));

    for (let len = 2; len <= n; len++) {
        for (let i = 1; i <= n - len + 1; i++) {
            const j = i + len - 1;
            dp[i][j] = Infinity;
            for (let x = i; x <= j; x++) {
                dp[i][j] = Math.min(dp[i][j], x + Math.max(dp[i][x - 1], dp[x + 1][j]));
            }
        }
    }

    return dp[1][n];
};