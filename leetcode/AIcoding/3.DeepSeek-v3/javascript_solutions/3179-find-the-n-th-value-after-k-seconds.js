var valueAfterKSeconds = function(n, k) {
    const MOD = 1e9 + 7;
    let dp = new Array(n).fill(1);
    for (let i = 1; i <= k; i++) {
        for (let j = 1; j < n; j++) {
            dp[j] = (dp[j] + dp[j - 1]) % MOD;
        }
    }
    return dp[n - 1];
};