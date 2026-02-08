var maxSumAfterPartitioning = function(arr, k) {
    const n = arr.length;
    const dp = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        let currentMax = 0;
        let currentPartitionLength = 0;
        for (let j = 1; j <= k; j++) {
            if (i - j < 0) {
                break;
            }
            currentMax = Math.max(currentMax, arr[i - j]);
            currentPartitionLength = j;
            dp[i] = Math.max(dp[i], dp[i - j] + currentMax * currentPartitionLength);
        }
    }

    return dp[n];
};