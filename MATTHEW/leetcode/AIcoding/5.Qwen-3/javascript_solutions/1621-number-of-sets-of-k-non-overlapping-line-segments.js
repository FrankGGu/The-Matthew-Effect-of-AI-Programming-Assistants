var numberOfSets = function(n, k) {
    const MOD = 10 ** 9 + 7;
    const dp = new Array(n + 1).fill(0).map(() => new Array(k + 1).fill(0));

    for (let i = 0; i <= n; i++) {
        dp[i][0] = 1;
    }

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= k; j++) {
            dp[i][j] = (dp[i - 1][j] + dp[i - 1][j - 1]) % MOD;
            if (i >= 2) {
                dp[i][j] = (dp[i][j] + dp[i - 2][j - 1]) % MOD;
            }
        }
    }

    return dp[n][k];
};