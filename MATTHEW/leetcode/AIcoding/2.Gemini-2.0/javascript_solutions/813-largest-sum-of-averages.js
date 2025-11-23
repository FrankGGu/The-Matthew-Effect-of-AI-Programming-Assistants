var largestSumOfAverages = function(nums, k) {
    const n = nums.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    const dp = new Array(n + 1).fill(0);
    for (let i = 1; i <= n; i++) {
        dp[i] = prefixSum[i] / i;
    }

    for (let i = 2; i <= k; i++) {
        for (let j = n; j >= 1; j--) {
            for (let x = 1; x < j; x++) {
                dp[j] = Math.max(dp[j], dp[x] + (prefixSum[j] - prefixSum[x]) / (j - x));
            }
        }
    }

    return dp[n];
};