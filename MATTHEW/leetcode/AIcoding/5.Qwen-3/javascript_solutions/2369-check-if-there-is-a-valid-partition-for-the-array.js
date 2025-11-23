function validPartition(nums) {
    const n = nums.length;
    const dp = new Array(n + 1).fill(false);
    dp[0] = true;

    for (let i = 3; i <= n; i++) {
        if (dp[i - 3] && nums[i - 1] === nums[i - 2] && nums[i - 2] === nums[i - 3]) {
            dp[i] = true;
        } else if (dp[i - 2] && nums[i - 1] === nums[i - 2]) {
            dp[i] = true;
        } else if (dp[i - 1] && nums[i - 1] === nums[i - 2] + 1 && nums[i - 2] === nums[i - 3] + 1) {
            dp[i] = true;
        }
    }

    return dp[n];
}