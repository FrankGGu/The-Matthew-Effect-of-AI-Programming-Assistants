var maxProduct = function(nums, k) {
    const n = nums.length;
    const dp = Array(n + 1).fill(0).map(() => Array(k + 1).fill(-Infinity));
    dp[0][0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= k; j++) {
            dp[i][j] = dp[i - 1][j];
            if (j >= nums[i - 1]) {
                dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - nums[i - 1]] * nums[i - 1]);
            }
        }
    }

    let maxProd = 0;
    for (let j = 0; j <= k; j++) {
        maxProd = Math.max(maxProd, dp[n][j]);
    }

    return maxProd;
};