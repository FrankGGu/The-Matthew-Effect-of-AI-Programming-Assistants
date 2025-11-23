var lengthOfLongestSubsequence = function(nums, target) {
    const n = nums.length;
    const dp = Array(target + 1).fill(-1);
    dp[0] = 0;

    for (let i = 0; i < n; i++) {
        for (let j = target; j >= nums[i]; j--) {
            if (dp[j - nums[i]] !== -1) {
                dp[j] = Math.max(dp[j], dp[j - nums[i]] + 1);
            }
        }
    }

    return dp[target];
};