var maxCoins = function(nums) {
    nums = [1, ...nums, 1];
    const n = nums.length;
    const dp = Array(n).fill(null).map(() => Array(n).fill(0));

    for (let len = 2; len < n; len++) {
        for (let i = 0; i < n - len; i++) {
            let j = i + len;
            for (let k = i + 1; k < j; k++) {
                dp[i][j] = Math.max(dp[i][j], dp[i][k] + nums[i] * nums[k] * nums[j] + dp[k][j]);
            }
        }
    }

    return dp[0][n - 1];
};