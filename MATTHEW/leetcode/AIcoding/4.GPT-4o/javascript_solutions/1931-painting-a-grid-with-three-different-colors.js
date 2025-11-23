var colorTheGrid = function(m, n) {
    const MOD = 1e9 + 7;
    const dp = new Array(n + 1).fill(0);
    const dp2 = new Array(n + 1).fill(0);

    dp[0] = 1;

    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            dp2[j] = (dp[j] * 3 + dp[j - 1] * 2) % MOD;
        }
        [dp, dp2] = [dp2, dp];
    }

    return dp[n];
};