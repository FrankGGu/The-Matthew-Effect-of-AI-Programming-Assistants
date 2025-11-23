function numberOfSets(...args) {
    const n = args[0];
    const k = args[1];
    const mod = 1000000007;
    const dp = Array.from({ length: n + 1 }, () => Array(k + 1).fill(0));
    for (let i = 0; i <= n; i++) {
        dp[i][0] = 1;
    }
    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= k; j++) {
            dp[i][j] = (dp[i - 1][j] + dp[i - 1][j - 1]) % mod;
        }
    }
    return dp[n][k];
}