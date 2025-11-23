var maximizeTheProfit = function(nums, k) {
    const n = nums.length;
    const dp = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1];
        for (let j = 0; j < nums.length; j++) {
            if (nums[j][1] === i - 1) {
                let start = nums[j][0];
                let reward = nums[j][2];
                dp[i] = Math.max(dp[i], (start === 0 ? 0 : dp[start]) + reward);
            }
        }
    }

    return dp[n];
};