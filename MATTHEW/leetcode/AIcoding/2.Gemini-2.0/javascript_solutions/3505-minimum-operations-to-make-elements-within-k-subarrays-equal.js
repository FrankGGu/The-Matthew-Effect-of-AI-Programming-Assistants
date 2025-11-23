var minOperations = function(nums, k) {
    const n = nums.length;
    const dp = Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + 1;
        for (let j = 1; j <= k && i - j >= 0; j++) {
            if (nums[i - 1] === nums[i - j - 1]) {
                dp[i] = Math.min(dp[i], dp[i - j - 1] + 1);
            }
        }
    }

    return dp[n] - 1;
};