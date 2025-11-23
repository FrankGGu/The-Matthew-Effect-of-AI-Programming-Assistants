var numRollsToTarget = function(n, k, target) {
    const MOD = 1e9 + 7;
    let dp = new Array(n + 1).fill().map(() => new Array(target + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= target; j++) {
            for (let face = 1; face <= k; face++) {
                if (j >= face) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - face]) % MOD;
                }
            }
        }
    }

    return dp[n][target];
};