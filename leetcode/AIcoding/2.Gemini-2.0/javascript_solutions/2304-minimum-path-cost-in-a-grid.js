var minPathCost = function(grid, moveCost) {
    const m = grid.length;
    const n = grid[0].length;
    let dp = Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        dp[i] = grid[0][i];
    }

    for (let i = 1; i < m; i++) {
        let newDp = Array(n).fill(Infinity);
        for (let j = 0; j < n; j++) {
            for (let k = 0; k < n; k++) {
                newDp[k] = Math.min(newDp[k], dp[j] + moveCost[grid[i - 1][j]][k] + grid[i][k]);
            }
        }
        dp = newDp;
    }

    let minCost = Infinity;
    for (let i = 0; i < n; i++) {
        minCost = Math.min(minCost, dp[i]);
    }

    return minCost;
};