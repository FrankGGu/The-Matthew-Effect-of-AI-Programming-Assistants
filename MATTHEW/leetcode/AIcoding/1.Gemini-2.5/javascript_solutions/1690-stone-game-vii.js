var stoneGameVII = function(stones) {
    const n = stones.length;

    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + stones[i];
    }

    const dp = Array(n).fill(0).map(() => Array(n).fill(0));

    for (let len = 2; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            const j = i + len - 1;

            const current_sum = prefixSum[j + 1] - prefixSum[i];

            const option1 = (current_sum - stones[i]) - dp[i + 1][j];
            const option2 = (current_sum - stones[j]) - dp[i][j - 1];

            dp[i][j] = Math.max(option1, option2);
        }
    }

    return dp[0][n - 1];
};