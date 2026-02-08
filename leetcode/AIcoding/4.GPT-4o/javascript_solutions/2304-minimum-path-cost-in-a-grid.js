var minPathCost = function(grid, moveCost) {
    const m = grid.length, n = grid[0].length;
    const dp = Array.from({ length: m }, () => Array(n).fill(Infinity));

    for (let j = 0; j < n; j++) {
        dp[0][j] = grid[0][j];
    }

    for (let i = 1; i < m; i++) {
        for (let j = 0; j < n; j++) {
            for (let k = 0; k < n; k++) {
                dp[i][j] = Math.min(dp[i][j], dp[i - 1][k] + grid[i][j] + moveCost[k][j]);
            }
        }
    }

    return Math.min(...dp[m - 1]);
};