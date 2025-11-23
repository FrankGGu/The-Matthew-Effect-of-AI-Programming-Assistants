var stoneGameVIII = function(stones) {
    const n = stones.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + stones[i];
    }

    const dp = new Array(n).fill(0);
    dp[n - 1] = prefixSum[n];

    for (let i = n - 2; i >= 1; i--) {
        dp[i] = Math.max(prefixSum[i + 1] - dp[i + 1], dp[i + 1]);
    }

    return dp[1];
};