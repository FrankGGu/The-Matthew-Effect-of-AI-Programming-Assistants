var countPaths = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const MOD = 10 ** 9 + 7;

    const memo = Array(m).fill(0).map(() => Array(n).fill(-1));

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    const dfs = (r, c) => {
        if (memo[r][c] !== -1) {
            return memo[r][c];
        }

        let count = 1;

        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] > grid[r][c]) {
                count = (count + dfs(nr, nc)) % MOD;
            }
        }

        memo[r][c] = count;
        return count;
    };

    let totalPaths = 0;
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            totalPaths = (totalPaths + dfs(r, c)) % MOD;
        }
    }

    return totalPaths;
};