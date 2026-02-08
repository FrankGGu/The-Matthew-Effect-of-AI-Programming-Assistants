var countBalancedPermutations = function(n) {
    const MOD = 10**9 + 7;

    if (n === 0) {
        return 1;
    }
    if (n === 1) {
        return 0;
    }

    let dp = new Array(n + 1);
    dp[0] = 1;
    dp[1] = 0;

    for (let i = 2; i <= n; i++) {
        let sum = (dp[i - 1] + dp[i - 2]) % MOD;
        dp[i] = ((i - 1) * sum) % MOD;
    }

    return dp[n];
};