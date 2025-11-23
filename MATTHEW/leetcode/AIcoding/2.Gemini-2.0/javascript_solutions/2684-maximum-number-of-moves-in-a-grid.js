var maxMoves = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let dp = Array(m).fill(0);

    for (let j = 0; j < n - 1; j++) {
        let nextDp = Array(m).fill(-1);
        for (let i = 0; i < m; i++) {
            if (j === 0 || dp[i] >= j) {
                if (i > 0 && grid[i - 1][j + 1] > grid[i][j]) {
                    nextDp[i - 1] = Math.max(nextDp[i - 1], j + 1);
                }
                if (grid[i][j + 1] > grid[i][j]) {
                    nextDp[i] = Math.max(nextDp[i], j + 1);
                }
                if (i < m - 1 && grid[i + 1][j + 1] > grid[i][j]) {
                    nextDp[i + 1] = Math.max(nextDp[i + 1], j + 1);
                }
            }
        }
        dp = nextDp;
    }

    let max = 0;
    for (let i = 0; i < m; i++) {
        max = Math.max(max, dp[i]);
    }

    return max;
};