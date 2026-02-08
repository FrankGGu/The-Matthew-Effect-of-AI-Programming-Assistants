var countBalancedPermutations = function(n) {
    if (n % 2 === 1) return 0;
    const MOD = 1e9 + 7;
    const dp = new Array(n + 1).fill(0);
    dp[0] = 1;
    for (let i = 2; i <= n; i += 2) {
        for (let j = 0; j < i; j += 2) {
            dp[i] = (dp[i] + dp[j] * dp[i - 2 - j]) % MOD;
        }
    }
    return dp[n];
};