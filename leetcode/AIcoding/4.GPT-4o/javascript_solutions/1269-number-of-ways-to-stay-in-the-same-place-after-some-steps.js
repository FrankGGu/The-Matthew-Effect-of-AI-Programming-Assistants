var numWays = function(steps, arrLen) {
    const mod = 1e9 + 7;
    const maxPos = Math.min(arrLen - 1, steps);
    const dp = Array(maxPos + 1).fill(0);
    dp[0] = 1;

    for (let s = 0; s < steps; s++) {
        const newDp = Array(maxPos + 1).fill(0);
        for (let p = 0; p <= maxPos; p++) {
            newDp[p] = dp[p];
            if (p > 0) newDp[p] = (newDp[p] + dp[p - 1]) % mod;
            if (p < maxPos) newDp[p] = (newDp[p] + dp[p + 1]) % mod;
        }
        dp = newDp;
    }

    return dp[0];
};