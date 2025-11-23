var minimumOperations = function(leaves) {
    const n = leaves.length;
    const dp = Array(n).fill(null).map(() => Array(3).fill(Infinity));

    dp[0][0] = leaves[0] === 'r' ? 0 : 1;

    for (let i = 1; i < n; i++) {
        if (leaves[i] === 'r') {
            dp[i][0] = dp[i - 1][0];
            dp[i][1] = Math.min(dp[i - 1][0], dp[i - 1][1]) + 1;
            dp[i][2] = Math.min(dp[i - 1][1], dp[i - 1][2]);
        } else {
            dp[i][0] = dp[i - 1][0] + 1;
            dp[i][1] = Math.min(dp[i - 1][0], dp[i - 1][1]);
            dp[i][2] = Math.min(dp[i - 1][1], dp[i - 1][2]) + 1;
        }
    }

    return dp[n - 1][2];
};