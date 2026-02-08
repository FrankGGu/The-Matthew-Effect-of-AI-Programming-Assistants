var minimumPairRemoval = function(nums) {
    let n = nums.length;
    let dp = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + 1;
        for (let j = 1; j < i; j++) {
            if (nums[i - 1] >= nums[j - 1]) {
                dp[i] = Math.min(dp[i], dp[j - 1] + (i - j - 1));
            }
        }
    }

    return dp[n];
};