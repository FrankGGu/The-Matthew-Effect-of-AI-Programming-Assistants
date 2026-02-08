const kInversePairs = function(n, k) {
    const MOD = 1e9 + 7;
    let dp = new Array(k + 1).fill(0);
    dp[0] = 1;
    for (let i = 1; i <= n; i++) {
        const temp = new Array(k + 1).fill(0);
        temp[0] = 1;
        for (let j = 1; j <= k; j++) {
            temp[j] = (temp[j - 1] + dp[j]) % MOD;
            if (j >= i) {
                temp[j] = (temp[j] - dp[j - i] + MOD) % MOD;
            }
        }
        dp = temp;
    }
    return dp[k];
};