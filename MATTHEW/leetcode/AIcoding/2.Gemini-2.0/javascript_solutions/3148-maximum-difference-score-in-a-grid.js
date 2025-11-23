var maxDiff = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let maxScore = -Infinity;
    let dp = Array(m).fill(null).map(() => Array(n).fill(-Infinity));
    dp[0][0] = grid[0][0];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (i > 0 && dp[i - 1][j] !== -Infinity) {
                dp[i][j] = Math.max(dp[i][j], dp[i - 1][j] - grid[i][j]);
            }
            if (j > 0 && dp[i][j - 1] !== -Infinity) {
                dp[i][j] = Math.max(dp[i][j], dp[i][j - 1] - grid[i][j]);
            }
        }
    }

    if(dp[m-1][n-1] !== -Infinity)
        maxScore = dp[m-1][n-1];

    return maxScore;
};