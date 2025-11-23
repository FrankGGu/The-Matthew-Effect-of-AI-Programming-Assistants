var largestSumOfAverages = function(nums, k) {
    const n = nums.length;

    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    const dp = Array(k + 1).fill(0).map(() => Array(n + 1).fill(0));

    for (let i = 1; i <= n; i++) {
        dp[1][i] = prefixSum[i] / i;
    }

    for (let p = 2; p <= k; p++) {
        for (let i = p; i <= n; i++) {
            for (let j = p - 1; j < i; j++) {
                const currentGroupSum = prefixSum[i] - prefixSum[j];
                const currentGroupCount = i - j;
                const currentGroupAverage = currentGroupSum / currentGroupCount;
                dp[p][i] = Math.max(dp[p][i], dp[p - 1][j] + currentGroupAverage);
            }
        }
    }

    let maxAverageSum = 0;
    for (let p = 1; p <= k; p++) {
        maxAverageSum = Math.max(maxAverageSum, dp[p][n]);
    }

    return maxAverageSum;
};