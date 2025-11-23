var countGoodStrings = function(low, high, zero, one) {
    const MOD = 10 ** 9 + 7;
    const dp = new Array(high + 1).fill(0);
    dp[0] = 1;
    let totalWays = 0;

    for (let i = 1; i <= high; i++) {
        if (i >= zero) {
            dp[i] = (dp[i] + dp[i - zero]) % MOD;
        }
        if (i >= one) {
            dp[i] = (dp[i] + dp[i - one]) % MOD;
        }

        if (i >= low) {
            totalWays = (totalWays + dp[i]) % MOD;
        }
    }

    return totalWays;
};