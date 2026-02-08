var stoneGameVII = function(stones) {
    const n = stones.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + stones[i];
    }

    const dp = new Array(n).fill(0).map(() => new Array(n).fill(0));

    for (let length = 2; length <= n; length++) {
        for (let i = 0; i <= n - length; i++) {
            const j = i + length - 1;
            const sumLeft = prefixSum[j + 1] - prefixSum[i + 1];
            const sumRight = prefixSum[j] - prefixSum[i];
            dp[i][j] = Math.max(sumLeft - dp[i + 1][j], sumRight - dp[i][j - 1]);
        }
    }

    return dp[0][n - 1];
};