var countPyramids = function(grid) {
    const m = grid.length, n = grid[0].length;
    const dp = Array.from({ length: m }, () => Array(n).fill(0));
    let count = 0;

    for (let i = m - 1; i >= 0; i--) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                dp[i][j] = 1 + (i + 1 < m ? Math.min(dp[i + 1][j - 1] || 0, dp[i + 1][j] || 0, dp[i + 1][j + 1] || 0) : 0);
                count += dp[i][j];
            }
        }
    }

    return count;
};