var stoneGameVII = function(stones) {
    const n = stones.length;
    const sum = stones.reduce((a, b) => a + b, 0);
    const dp = Array(n).fill(0).map(() => Array(n).fill(0));

    for (let len = 2; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            let j = i + len - 1;
            dp[i][j] = Math.max(
                sum - stones[i] - dp[i + 1][j],
                sum - stones[j] - dp[i][j - 1]
            );
        }
    }

    return dp[0][n - 1];
};