var kInversePairs = function(n, k) {
    const MOD = 1000000007;
    const dp = Array(n + 1).fill(0).map(() => Array(k + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= k; j++) {
            dp[i][j] = dp[i - 1][j];
            if (j > 0) dp[i][j] = (dp[i][j] + dp[i][j - 1]) % MOD;
            if (j >= i) dp[i][j] = (dp[i][j] - dp[i - 1][j - i] + MOD) % MOD;
        }
    }

    return dp[n][k];
};