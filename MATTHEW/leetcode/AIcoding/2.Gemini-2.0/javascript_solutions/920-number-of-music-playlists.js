var numMusicPlaylists = function(n, goal, k) {
    const MOD = 10**9 + 7;
    const dp = Array(goal + 1).fill(null).map(() => Array(n + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 1; i <= goal; i++) {
        for (let j = 1; j <= n; j++) {
            dp[i][j] = (dp[i][j] + dp[i - 1][j - 1] * (n - j + 1)) % MOD;
            dp[i][j] = (dp[i][j] + dp[i - 1][j] * Math.max(0, j - k)) % MOD;
        }
    }

    return dp[goal][n];
};