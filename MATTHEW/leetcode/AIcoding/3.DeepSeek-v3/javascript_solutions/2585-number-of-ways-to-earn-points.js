var waysToReachTarget = function(target, types) {
    const MOD = 1e9 + 7;
    const n = types.length;
    const dp = new Array(target + 1).fill(0);
    dp[0] = 1;

    for (let i = 0; i < n; i++) {
        const [count, marks] = types[i];
        for (let j = target; j >= 0; j--) {
            for (let k = 1; k <= count; k++) {
                if (j - k * marks >= 0) {
                    dp[j] = (dp[j] + dp[j - k * marks]) % MOD;
                }
            }
        }
    }

    return dp[target];
};