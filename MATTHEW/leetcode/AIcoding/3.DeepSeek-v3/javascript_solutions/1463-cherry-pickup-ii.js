var cherryPickup = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dp = new Array(m).fill().map(() => 
        new Array(n).fill().map(() => new Array(n).fill(-1))
    );

    function dfs(row, col1, col2) {
        if (col1 < 0 || col1 >= n || col2 < 0 || col2 >= n) {
            return -Infinity;
        }
        if (row === m - 1) {
            return col1 === col2 ? grid[row][col1] : grid[row][col1] + grid[row][col2];
        }
        if (dp[row][col1][col2] !== -1) {
            return dp[row][col1][col2];
        }

        let maxCherries = 0;
        const currentCherry = col1 === col2 ? grid[row][col1] : grid[row][col1] + grid[row][col2];

        for (let d1 = -1; d1 <= 1; d1++) {
            for (let d2 = -1; d2 <= 1; d2++) {
                const newCol1 = col1 + d1;
                const newCol2 = col2 + d2;
                maxCherries = Math.max(maxCherries, dfs(row + 1, newCol1, newCol2));
            }
        }

        dp[row][col1][col2] = currentCherry + maxCherries;
        return dp[row][col1][col2];
    }

    return dfs(0, 0, n - 1);
};