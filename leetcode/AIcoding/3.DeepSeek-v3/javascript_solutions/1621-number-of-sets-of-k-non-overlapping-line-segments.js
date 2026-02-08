var numberOfSets = function(n, k) {
    const MOD = 1e9 + 7;
    const dp = new Array(n + 1).fill().map(() => new Array(k + 1).fill(0));
    const prefix = new Array(n + 1).fill().map(() => new Array(k + 1).fill(0));

    for (let i = 1; i <= n; i++) {
        dp[i][0] = 1;
    }

    for (let i = 2; i <= n; i++) {
        for (let j = 1; j <= k; j++) {
            prefix[i][j] = (prefix[i - 1][j] + dp[i - 1][j]) % MOD;
            dp[i][j] = (dp[i - 1][j] + prefix[i][j - 1]) % MOD;
        }
    }

    return dp[n][k];
};