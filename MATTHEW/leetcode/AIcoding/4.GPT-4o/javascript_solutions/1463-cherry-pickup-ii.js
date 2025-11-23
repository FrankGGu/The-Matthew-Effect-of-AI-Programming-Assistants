var cherryPickupII = function(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    const dp = Array.from({ length: rows + 1 }, () => Array.from({ length: cols }, () => Array(cols).fill(0)));

    for (let r = rows - 1; r >= 0; r--) {
        for (let c1 = 0; c1 < cols; c1++) {
            for (let c2 = 0; c2 < cols; c2++) {
                let cherries = grid[r][c1];
                if (c1 !== c2) cherries += grid[r][c2];
                let maxCherries = 0;

                for (let nc1 = c1 - 1; nc1 <= c1 + 1; nc1++) {
                    for (let nc2 = c2 - 1; nc2 <= c2 + 1; nc2++) {
                        if (nc1 >= 0 && nc1 < cols && nc2 >= 0 && nc2 < cols) {
                            maxCherries = Math.max(maxCherries, dp[r + 1][nc1][nc2]);
                        }
                    }
                }
                dp[r][c1][c2] = cherries + maxCherries;
            }
        }
    }

    return dp[0][0][cols - 1];
};