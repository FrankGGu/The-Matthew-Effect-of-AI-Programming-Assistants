function numBalancedPermutations(n, k) {
    const MOD = 1000000007;
    const max = n * 2;
    const dp = Array.from({ length: max + 1 }, () => Array(max + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 1; i <= max; i++) {
        for (let j = 0; j <= i; j++) {
            if (i - 1 >= 0 && j - 1 >= 0) {
                dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % MOD;
            }
            if (i - 1 >= 0 && j + 1 <= max) {
                dp[i][j] = (dp[i][j] + dp[i - 1][j + 1]) % MOD;
            }
        }
    }

    return dp[n * 2][k];
}