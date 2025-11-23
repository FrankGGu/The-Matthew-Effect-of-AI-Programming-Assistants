function sumOfSubsequencePowers(nums, x) {
    const MOD = 10 ** 9 + 7;
    const dp = new Array(x + 1).fill(0);
    dp[0] = 1;

    for (const num of nums) {
        for (let i = x; i >= num; i--) {
            dp[i] = (dp[i] + dp[i - num]) % MOD;
        }
    }

    return dp[x];
}