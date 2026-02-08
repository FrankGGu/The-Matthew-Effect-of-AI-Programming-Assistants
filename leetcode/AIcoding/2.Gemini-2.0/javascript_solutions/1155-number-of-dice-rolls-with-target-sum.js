var numRollsToTarget = function(n, k, target) {
    const MOD = 10**9 + 7;
    let dp = new Array(target + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; i <= n; i++) {
        let newDp = new Array(target + 1).fill(0);
        for (let j = 1; j <= target; j++) {
            for (let face = 1; face <= k; face++) {
                if (j >= face) {
                    newDp[j] = (newDp[j] + dp[j - face]) % MOD;
                }
            }
        }
        dp = newDp;
    }

    return dp[target];
};