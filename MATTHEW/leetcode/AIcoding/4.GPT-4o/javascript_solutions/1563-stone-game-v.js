var stoneGameV = function(stoneValue) {
    const n = stoneValue.length;
    const dp = new Array(n + 1).fill(0);
    const prefixSum = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        prefixSum[i] = prefixSum[i - 1] + stoneValue[i - 1];
    }

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j < i; j++) {
            const left = prefixSum[j];
            const right = prefixSum[i] - left;
            if (left > right) {
                dp[i] = Math.max(dp[i], dp[j] + right);
            } else if (left < right) {
                dp[i] = Math.max(dp[i], dp[j] + left);
            } else {
                dp[i] = Math.max(dp[i], dp[j] + left, dp[j] + right);
            }
        }
    }

    return dp[n];
};