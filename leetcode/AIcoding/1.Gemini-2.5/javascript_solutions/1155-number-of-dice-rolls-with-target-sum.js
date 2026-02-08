var numRollsToTarget = function(n, f, target) {
    const MOD = 10**9 + 7;

    const dp = Array(n + 1).fill(0).map(() => Array(target + 1).fill(0));

    dp[0][0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= target; j++) {
            for (let k = 1; k <= f; k++) {
                if (j - k >= 0) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - k]) % MOD;
                }
            }
        }
    }

    return dp[n][target];
};