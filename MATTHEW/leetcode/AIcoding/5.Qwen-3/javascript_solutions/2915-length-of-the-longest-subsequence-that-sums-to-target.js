function lengthOfLongestSubsequence(nums, target) {
    const dp = new Array(target + 1).fill(0);
    for (let i = 0; i < nums.length; i++) {
        for (let j = target; j >= nums[i]; j--) {
            dp[j] = Math.max(dp[j], dp[j - nums[i]] + 1);
        }
    }
    return dp[target];
}