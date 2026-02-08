var validPartition = function(nums) {
    const n = nums.length;
    const dp = new Array(n + 1).fill(false);
    dp[0] = true;

    for (let i = 1; i <= n; i++) {
        if (i >= 2 && dp[i - 2] && nums[i - 1] === nums[i - 2]) {
            dp[i] = true;
        }
        if (i >= 3 && dp[i - 3] && (
            (nums[i - 1] === nums[i - 2] && nums[i - 2] === nums[i - 3]) ||
            (nums[i - 1] === nums[i - 2] + 1 && nums[i - 2] === nums[i - 3] + 1)
        )) {
            dp[i] = true;
        }
    }

    return dp[n];
};