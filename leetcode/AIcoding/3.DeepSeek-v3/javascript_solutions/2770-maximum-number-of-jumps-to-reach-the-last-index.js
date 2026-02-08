var maximumJumps = function(nums, target) {
    const n = nums.length;
    const dp = new Array(n).fill(-1);
    dp[0] = 0;

    for (let i = 1; i < n; i++) {
        for (let j = 0; j < i; j++) {
            if (dp[j] !== -1 && Math.abs(nums[i] - nums[j]) <= target) {
                if (dp[i] < dp[j] + 1) {
                    dp[i] = dp[j] + 1;
                }
            }
        }
    }

    return dp[n - 1] === -1 ? -1 : dp[n - 1];
};