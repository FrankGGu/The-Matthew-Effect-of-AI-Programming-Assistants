var lengthOfLongestSubsequence = function(nums, target) {
    const dp = new Array(target + 1).fill(-Infinity);
    dp[0] = 0;
    for (const num of nums) {
        for (let j = target; j >= num; j--) {
            if (dp[j - num] !== -Infinity) {
                dp[j] = Math.max(dp[j], dp[j - num] + 1);
            }
        }
    }
    return dp[target] === -Infinity ? -1 : dp[target];
};