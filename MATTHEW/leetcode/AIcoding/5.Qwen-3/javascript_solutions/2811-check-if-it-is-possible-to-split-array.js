function isSplitPossible(nums, m) {
    const n = nums.length;
    const dp = new Array(n).fill(0);
    for (let i = 0; i < n; i++) {
        dp[i] = nums[i];
        for (let j = 0; j < i; j++) {
            if (dp[j] >= m && nums[i] >= m) {
                return true;
            }
            dp[i] = Math.max(dp[i], dp[j] + nums[i]);
        }
    }
    return false;
}