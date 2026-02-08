var rearrangeSticks = function(n, k) {
    const MOD = 1000000007;
    const dp = Array.from({ length: n + 1 }, () => Array(k + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= Math.min(i, k); j++) {
            dp[i][j] = (dp[i - 1][j - 1] + (dp[i - 1][j] * (i - 1)) % MOD) % MOD;
        }
    }

    return dp[n][k];
};