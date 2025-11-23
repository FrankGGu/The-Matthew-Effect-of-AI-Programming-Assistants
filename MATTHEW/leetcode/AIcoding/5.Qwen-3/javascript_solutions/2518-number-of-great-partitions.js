function countGreatPartitions(nums) {
    const MOD = 10 ** 9 + 7;
    const n = nums.length;
    const dp = new Array(n + 1).fill(0);
    dp[0] = 1;
    for (let i = 0; i < n; i++) {
        const val = nums[i];
        for (let j = n; j > 0; j--) {
            dp[j] = (dp[j] + dp[j - 1]) % MOD;
        }
    }
    return dp[n];
}