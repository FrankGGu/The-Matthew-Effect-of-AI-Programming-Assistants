var countWays = function(n, k) {
    const MOD = 1000000007;
    if (n === 0) return 0;
    if (n === 1) return k;

    let dp = new Array(n + 1).fill(0);
    dp[1] = k;
    dp[2] = k * k - k;

    for (let i = 3; i <= n; i++) {
        dp[i] = (dp[i - 1] * (k - 1) + dp[i - 2] * (k - 1)) % MOD;
    }

    return dp[n];
};