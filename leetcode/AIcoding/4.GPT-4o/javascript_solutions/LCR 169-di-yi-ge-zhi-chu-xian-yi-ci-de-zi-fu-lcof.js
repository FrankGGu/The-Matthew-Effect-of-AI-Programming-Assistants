var numWays = function(steps, arrLen) {
    const mod = 1e9 + 7;
    const maxPos = Math.min(steps, arrLen - 1);
    const dp = new Array(maxPos + 1).fill(0);
    dp[0] = 1;

    for (let i = 0; i < steps; i++) {
        const newDp = new Array(maxPos + 1).fill(0);
        for (let j = 0; j <= maxPos; j++) {
            newDp[j] = (newDp[j] + dp[j]) % mod;
            if (j > 0) newDp[j] = (newDp[j] + dp[j - 1]) % mod;
            if (j < maxPos) newDp[j] = (newDp[j] + dp[j + 1]) % mod;
        }
        dp = newDp;
    }

    return dp[0];
};