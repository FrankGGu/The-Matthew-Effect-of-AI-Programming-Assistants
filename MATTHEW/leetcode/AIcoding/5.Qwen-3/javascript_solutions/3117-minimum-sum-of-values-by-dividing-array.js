function minSum(nums, k) {
    const n = nums.length;
    const dp = new Array(n).fill(0).map(() => new Array(k + 1).fill(0));

    for (let i = 0; i < n; i++) {
        dp[i][1] = nums[i];
    }

    for (let j = 2; j <= k; j++) {
        for (let i = 0; i < n; i++) {
            let minVal = Infinity;
            for (let m = 0; m < i; m++) {
                minVal = Math.min(minVal, dp[m][j - 1] + nums[i]);
            }
            dp[i][j] = minVal;
        }
    }

    return dp[n - 1][k];
}