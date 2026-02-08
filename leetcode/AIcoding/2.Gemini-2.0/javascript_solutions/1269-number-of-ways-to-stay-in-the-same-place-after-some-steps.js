var numWays = function(steps, arrLen) {
    const MOD = 10**9 + 7;
    const maxPos = Math.min(steps, arrLen - 1);
    let dp = Array(maxPos + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; i <= steps; i++) {
        let newDp = Array(maxPos + 1).fill(0);
        for (let j = 0; j <= maxPos; j++) {
            newDp[j] = (newDp[j] + dp[j]) % MOD;
            if (j > 0) {
                newDp[j] = (newDp[j] + dp[j - 1]) % MOD;
            }
            if (j < maxPos) {
                newDp[j] = (newDp[j] + dp[j + 1]) % MOD;
            }
        }
        dp = newDp;
    }

    return dp[0];
};