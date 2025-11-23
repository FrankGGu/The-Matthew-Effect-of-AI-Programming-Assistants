var kInversePairs = function(n, k) {
    const MOD = 10**9 + 7;
    let dp = Array(k + 1).fill(0);
    dp[0] = 1;

    for (let i = 2; i <= n; i++) {
        let newDp = Array(k + 1).fill(0);
        newDp[0] = 1;
        for (let j = 1; j <= k; j++) {
            newDp[j] = (newDp[j - 1] + dp[j]) % MOD;
            if (j >= i) {
                newDp[j] = (newDp[j] - dp[j - i] + MOD) % MOD;
            }
        }
        dp = newDp;
    }

    return dp[k];
};