var numberOfSets = function(n, k) {
    const MOD = 10**9 + 7;
    let dp = Array(n).fill(null).map(() => Array(k + 1).fill(0));
    let sum = Array(n).fill(null).map(() => Array(k + 1).fill(0));

    for (let i = 0; i < n; i++) {
        dp[i][0] = 1;
        sum[i][0] = i + 1;
    }

    for (let j = 1; j <= k; j++) {
        dp[0][j] = 0;
        sum[0][j] = 0;
    }

    for (let i = 1; i < n; i++) {
        for (let j = 1; j <= k; j++) {
            dp[i][j] = (dp[i - 1][j] + sum[i - 1][j - 1]) % MOD;
            sum[i][j] = (sum[i - 1][j] + dp[i][j]) % MOD;
        }
    }

    return dp[n - 1][k];
};