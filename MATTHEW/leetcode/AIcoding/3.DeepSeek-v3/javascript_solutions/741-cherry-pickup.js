var cherryPickup = function(grid) {
    const n = grid.length;
    const memo = new Array(n).fill().map(() => 
        new Array(n).fill().map(() => 
            new Array(n).fill(-Infinity)
    );

    const dp = (r1, c1, c2) => {
        const r2 = r1 + c1 - c2;
        if (r1 >= n || c1 >= n || r2 >= n || c2 >= n || 
            grid[r1][c1] === -1 || grid[r2][c2] === -1) {
            return -Infinity;
        }
        if (r1 === n - 1 && c1 === n - 1) {
            return grid[r1][c1];
        }
        if (memo[r1][c1][c2] !== -Infinity) {
            return memo[r1][c1][c2];
        }

        let res = grid[r1][c1];
        if (c1 !== c2) {
            res += grid[r2][c2];
        }

        res += Math.max(
            dp(r1, c1 + 1, c2 + 1),
            dp(r1 + 1, c1, c2 + 1),
            dp(r1, c1 + 1, c2),
            dp(r1 + 1, c1, c2)
        );

        memo[r1][c1][c2] = res;
        return res;
    };

    return Math.max(0, dp(0, 0, 0));
};