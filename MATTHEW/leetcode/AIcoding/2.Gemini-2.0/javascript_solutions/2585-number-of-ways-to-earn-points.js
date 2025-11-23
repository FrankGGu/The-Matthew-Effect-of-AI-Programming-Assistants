var numberOfWays = function(target, types) {
    const MOD = 1000000007;
    const dp = new Array(target + 1).fill(0);
    dp[0] = 1;

    for (const [count, points] of types) {
        for (let i = 1; i <= target; i++) {
            for (let k = 1; k <= count; k++) {
                if (i >= points * k) {
                    dp[i] = (dp[i] + dp[i - points * k]) % MOD;
                } else {
                    break;
                }
            }
        }
    }

    return dp[target];
};