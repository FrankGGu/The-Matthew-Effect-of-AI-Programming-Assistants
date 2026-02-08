var minCostToMergeBlocks = function(blocks) {
    const n = blocks.length;

    if (n <= 1) {
        return 0;
    }

    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + blocks[i];
    }

    const dp = Array(n).fill(0).map(() => Array(n).fill(Infinity));

    for (let i = 0; i < n; i++) {
        dp[i][i] = 0;
    }

    for (let len = 2; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            const j = i + len - 1;
            const currentSum = prefixSum[j + 1] - prefixSum[i];

            for (let k = i; k < j; k++) {
                dp[i][j] = Math.min(dp[i][j], dp[i][k] + dp[k + 1][j] + currentSum);
            }
        }
    }

    return dp[0][n - 1];
};