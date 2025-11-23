const MOD = 1e9 + 7;

var rearrangeSticks = function(n, k) {
    const dp = new Array(n + 1).fill().map(() => new Array(k + 1).fill(0));
    dp[0][0] = 1;
    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= k; j++) {
            dp[i][j] = (dp[i - 1][j - 1] + dp[i - 1][j] * (i - 1)) % MOD;
        }
    }
    return dp[n][k];
};