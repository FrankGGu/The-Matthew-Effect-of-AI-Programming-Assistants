var countWinningSequences = function(n, k, m) {
    const MOD = 1e9 + 7;
    let dp = new Array(n + 1).fill(0).map(() => new Array(k + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= k; j++) {
            for (let x = 1; x <= m; x++) {
                if (i >= x && j >= 1) {
                    dp[i][j] = (dp[i][j] + dp[i - x][j - 1]) % MOD;
                }
            }
        }
    }

    let total = 0;
    for (let j = 1; j <= k; j++) {
        total = (total + dp[n][j]) % MOD;
    }

    return total;
};