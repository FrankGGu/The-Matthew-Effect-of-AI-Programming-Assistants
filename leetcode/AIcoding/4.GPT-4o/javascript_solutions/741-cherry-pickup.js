var cherryPickup = function(grid) {
    const n = grid.length;
    const dp = Array.from({ length: n }, () => Array.from({ length: n }, () => Array(n).fill(-1)));

    const collectCherries = (r1, c1, c2) => {
        const r2 = r1 + c1 - c2;
        if (r1 >= n || c1 >= n || r2 >= n || c2 >= n || grid[r1][c1] === -1 || grid[r2][c2] === -1) {
            return -1;
        }
        if (r1 === n - 1 && c1 === n - 1) {
            return grid[r1][c1];
        }
        if (dp[r1][c1][c2] !== -1) {
            return dp[r1][c1][c2];
        }

        const cherries = grid[r1][c1] + (c1 !== c2 ? grid[r2][c2] : 0);
        const maxCherries = Math.max(
            collectCherries(r1 + 1, c1, c2),
            collectCherries(r1, c1 + 1, c2),
            collectCherries(r1 + 1, c1, c2 + 1),
            collectCherries(r1, c1 + 1, c2 + 1)
        );

        dp[r1][c1][c2] = cherries + maxCherries;
        return dp[r1][c1][c2];
    };

    return Math.max(0, collectCherries(0, 0, 0));
};