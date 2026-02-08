var countPaths = function(grid) {
    const MOD = 1e9 + 7;
    const m = grid.length;
    const n = grid[0].length;
    const dp = new Array(m).fill(0).map(() => new Array(n).fill(0));
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];

    let result = 0;

    function dfs(i, j) {
        if (dp[i][j] !== 0) return dp[i][j];
        dp[i][j] = 1;

        for (const [di, dj] of directions) {
            const ni = i + di;
            const nj = j + dj;
            if (ni >= 0 && ni < m && nj >= 0 && nj < n && grid[ni][nj] > grid[i][j]) {
                dp[i][j] = (dp[i][j] + dfs(ni, nj)) % MOD;
            }
        }

        return dp[i][j];
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            result = (result + dfs(i, j)) % MOD;
        }
    }

    return result;
};