var numberOfWays = function(startPos, endPos, k) {
    const MOD = 10 ** 9 + 7;
    const maxSteps = k;
    const dp = new Array(k + 1).fill(0).map(() => new Array(k + 1).fill(0));
    dp[0][0] = 1;

    for (let step = 1; step <= k; step++) {
        for (let pos = 0; pos <= k; pos++) {
            dp[step][pos] = (dp[step][pos] + dp[step - 1][pos]) % MOD;
            if (pos > 0) {
                dp[step][pos] = (dp[step][pos] + dp[step - 1][pos - 1]) % MOD;
            }
            if (pos < k) {
                dp[step][pos] = (dp[step][pos] + dp[step - 1][pos + 1]) % MOD;
            }
        }
    }

    return dp[k][endPos - startPos];
};