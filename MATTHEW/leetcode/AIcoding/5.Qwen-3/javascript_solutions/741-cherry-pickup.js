function cherryPickup(grid) {
    const n = grid.length;
    const memo = Array.from({ length: n }, () => Array.from({ length: n }, () => Array.from({ length: n }, () => -1)));

    function dfs(r1, c1, r2, c2) {
        if (r1 >= n || c1 >= n || r2 >= n || c2 >= n || grid[r1][c1] === -1 || grid[r2][c2] === -1) {
            return -Infinity;
        }
        if (r1 === n - 1 && c1 === n - 1) {
            return grid[r1][c1];
        }
        if (r2 === n - 1 && c2 === n - 1) {
            return grid[r1][c1];
        }
        if (memo[r1][c1][r2] !== -1) {
            return memo[r1][c1][r2];
        }

        const currentCherries = grid[r1][c1];
        if (r1 !== r2 || c1 !== c2) {
            currentCherries += grid[r2][c2];
        }

        let maxCherries = -Infinity;
        const directions = [[0, 1], [1, 0], [1, 1], [0, 0]];
        for (const [dr1, dc1] of directions) {
            for (const [dr2, dc2] of directions) {
                const cherries = dfs(r1 + dr1, c1 + dc1, r2 + dr2, c2 + dc2);
                maxCherries = Math.max(maxCherries, cherries);
            }
        }

        memo[r1][c1][r2] = currentCherries + maxCherries;
        return memo[r1][c1][r2];
    }

    const result = dfs(0, 0, 0, 0);
    return result < 0 ? 0 : result;
}