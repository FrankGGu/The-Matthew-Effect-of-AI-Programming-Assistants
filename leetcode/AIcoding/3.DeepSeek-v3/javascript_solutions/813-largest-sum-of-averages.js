var largestSumOfAverages = function(nums, k) {
    const n = nums.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    const dp = new Array(n + 1).fill(0).map(() => new Array(k + 1).fill(0));

    for (let i = 1; i <= n; i++) {
        dp[i][1] = prefixSum[i] / i;
    }

    for (let j = 2; j <= k; j++) {
        for (let i = j; i <= n; i++) {
            for (let m = j - 1; m < i; m++) {
                dp[i][j] = Math.max(dp[i][j], dp[m][j - 1] + (prefixSum[i] - prefixSum[m]) / (i - m));
            }
        }
    }

    return dp[n][k];
};