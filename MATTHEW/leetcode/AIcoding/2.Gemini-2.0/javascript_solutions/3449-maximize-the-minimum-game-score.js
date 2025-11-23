var maximizeTheMinimumGameScore = function(nums, k) {
    let n = nums.length;
    let prefixSum = new Array(n + 1).fill(0);
    for (let i = 1; i <= n; i++) {
        prefixSum[i] = prefixSum[i - 1] + nums[i - 1];
    }

    let dp = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1];
        for (let j = 1; j <= Math.min(i, k); j++) {
            let subSum = prefixSum[i] - prefixSum[i - j];
            let prevScore = (i - j > 0) ? dp[i - j] : 0;
            dp[i] = Math.max(dp[i], prevScore + subSum);
        }
    }

    return dp[n];
};