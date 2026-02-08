var minPathCost = function(grid, moveCost) {
    const m = grid.length;
    const n = grid[0].length;
    let dp = new Array(m).fill().map(() => new Array(n).fill(0));

    for (let j = 0; j < n; j++) {
        dp[0][j] = grid[0][j];
    }

    for (let i = 1; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let minCost = Infinity;
            for (let k = 0; k < n; k++) {
                const prevVal = grid[i-1][k];
                const cost = moveCost[prevVal][j];
                minCost = Math.min(minCost, dp[i-1][k] + cost);
            }
            dp[i][j] = minCost + grid[i][j];
        }
    }

    return Math.min(...dp[m-1]);
};