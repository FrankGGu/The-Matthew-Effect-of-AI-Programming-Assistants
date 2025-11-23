var cherryPickup = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dp = Array(m).fill(null).map(() => Array(n).fill(null).map(() => Array(n).fill(-1)));

    function solve(row, col1, col2) {
        if (row === m) {
            return 0;
        }

        if (dp[row][col1][col2] !== -1) {
            return dp[row][col1][col2];
        }

        let cherries = 0;
        cherries += grid[row][col1];
        if (col1 !== col2) {
            cherries += grid[row][col2];
        }

        let maxCherries = 0;
        for (let i = -1; i <= 1; i++) {
            for (let j = -1; j <= 1; j++) {
                const newCol1 = col1 + i;
                const newCol2 = col2 + j;

                if (newCol1 >= 0 && newCol1 < n && newCol2 >= 0 && newCol2 < n) {
                    maxCherries = Math.max(maxCherries, solve(row + 1, newCol1, newCol2));
                }
            }
        }

        cherries += maxCherries;
        dp[row][col1][col2] = cherries;
        return cherries;
    }

    return solve(0, 0, n - 1);
};