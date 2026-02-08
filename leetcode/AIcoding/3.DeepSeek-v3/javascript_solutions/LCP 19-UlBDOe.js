var minimumOperations = function(leaves) {
    const n = leaves.length;
    const dp = new Array(n).fill(0).map(() => new Array(3).fill(Infinity));
    dp[0][0] = leaves[0] === 'r' ? 0 : 1;

    for (let i = 1; i < n; i++) {
        for (let j = 0; j < 3; j++) {
            if (j === 0) {
                dp[i][j] = dp[i - 1][j] + (leaves[i] === 'r' ? 0 : 1);
            } else {
                if (i >= j) {
                    let cost = j === 1 ? (leaves[i] === 'y' ? 0 : 1) : (leaves[i] === 'r' ? 0 : 1);
                    dp[i][j] = Math.min(dp[i - 1][j], dp[i - 1][j - 1]) + cost;
                }
            }
        }
    }

    return dp[n - 1][2];
};