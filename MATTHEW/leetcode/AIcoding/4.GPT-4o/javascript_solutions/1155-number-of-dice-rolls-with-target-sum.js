var numRollsToTarget = function(d, f, target) {
    const MOD = 1e9 + 7;
    const dp = Array.from({length: d + 1}, () => Array(target + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 1; i <= d; i++) {
        for (let j = 1; j <= target; j++) {
            for (let k = 1; k <= f; k++) {
                if (j - k >= 0) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - k]) % MOD;
                }
            }
        }
    }

    return dp[d][target];
};