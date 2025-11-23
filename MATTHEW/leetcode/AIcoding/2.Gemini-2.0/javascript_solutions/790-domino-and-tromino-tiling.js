var numTilings = function(n) {
    const MOD = 10**9 + 7;
    if (n <= 2) return n;
    let dp = [0, 1, 2, 5];
    if (n <= 3) return dp[n];

    for (let i = 4; i <= n; i++) {
        dp[i] = (2 * dp[i-1] + dp[i-3]) % MOD;
    }

    return dp[n];
};