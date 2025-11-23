var maxScore = function(nums) {
    const n = nums.length;
    const dp = new Array(n).fill(-Infinity);
    dp[0] = nums[0];

    for (let i = 1; i < n; i++) {
        for (let j = Math.max(0, i - 6); j < i; j++) {
            dp[i] = Math.max(dp[i], dp[j] + nums[i]);
        }
    }

    return dp[n - 1];
};