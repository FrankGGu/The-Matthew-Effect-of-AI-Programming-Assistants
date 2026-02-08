var countPaths = function(grid, x) {
    const m = grid.length, n = grid[0].length;
    const dp = Array.from({ length: m }, () => Array(n).fill(0));
    dp[0][0] = grid[0][0];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (i > 0) dp[i][j] ^= dp[i - 1][j] ^ grid[i][j];
            if (j > 0) dp[i][j] ^= dp[i][j - 1] ^ grid[i][j];
        }
    }

    let count = 0;
    const dfs = (i, j, currentXor) => {
        if (i < 0 || j < 0) return;
        currentXor ^= grid[i][j];
        if (i === 0 && j === 0) {
            if (currentXor === x) count++;
            return;
        }
        dfs(i - 1, j, currentXor);
        dfs(i, j - 1, currentXor);
    };

    dfs(m - 1, n - 1, 0);
    return count;
};