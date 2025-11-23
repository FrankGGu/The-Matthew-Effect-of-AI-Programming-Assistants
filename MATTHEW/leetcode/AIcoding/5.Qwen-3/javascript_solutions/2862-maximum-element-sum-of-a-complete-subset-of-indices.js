function maximumElementSum(nums) {
    const n = nums.length;
    const dp = new Array(n).fill(0);
    dp[0] = nums[0];
    for (let i = 1; i < n; i++) {
        dp[i] = Math.max(dp[i - 1], nums[i]);
    }
    return dp[n - 1];
}