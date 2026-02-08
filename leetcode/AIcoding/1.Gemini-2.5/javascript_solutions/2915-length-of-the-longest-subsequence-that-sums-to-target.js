var longestSubsequence = function(nums, target) {
    const dp = new Array(target + 1).fill(-1);
    dp[0] = 0;

    for (const num of nums) {
        for (let s = target; s >= num; s--) {
            if (dp[s - num] !== -1) {
                dp[s] = Math.max(dp[s], dp[s - num] + 1);
            }
        }
    }

    return dp[target];
};