var numWays = function(steps, arrLen) {
    const MOD = 1e9 + 7;
    let maxPos = Math.min(steps, arrLen);
    let dp = new Array(maxPos + 2).fill(0);
    dp[0] = 1;

    for (let step = 1; step <= steps; step++) {
        let nextDp = new Array(maxPos + 2).fill(0);
        for (let pos = 0; pos < maxPos; pos++) {
            nextDp[pos] = dp[pos];
            if (pos > 0) {
                nextDp[pos] = (nextDp[pos] + dp[pos - 1]) % MOD;
            }
            if (pos < maxPos - 1) {
                nextDp[pos] = (nextDp[pos] + dp[pos + 1]) % MOD;
            }
        }
        dp = nextDp;
    }

    return dp[0];
};