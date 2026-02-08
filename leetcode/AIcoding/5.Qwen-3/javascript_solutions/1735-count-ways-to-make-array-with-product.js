function numWays(nums) {
    const MOD = 1000000007;
    const n = nums.length;
    const dp = new Array(n + 1).fill(0);
    dp[0] = 1;
    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1];
        if (i >= 2) {
            dp[i] = (dp[i] + dp[i - 2]) % MOD;
        }
    }
    return dp[n];
}