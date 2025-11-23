var mergeStones = function(stones, K) {
    const n = stones.length;
    if ((n - 1) % (K - 1) !== 0) return -1;

    const dp = Array.from({ length: n }, () => Array(n).fill(0));
    const prefixSum = Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + stones[i];
    }

    for (let len = K; len <= n; len++) {
        for (let i = 0; i + len - 1 < n; i++) {
            const j = i + len - 1;
            dp[i][j] = Infinity;
            for (let m = 1; m < len; m += K - 1) {
                dp[i][j] = Math.min(dp[i][j], dp[i][i + m - 1] + dp[i + m][j]);
            }
            if ((len - 1) % (K - 1) === 0) {
                dp[i][j] += prefixSum[j + 1] - prefixSum[i];
            }
        }
    }

    return dp[0][n - 1];
};