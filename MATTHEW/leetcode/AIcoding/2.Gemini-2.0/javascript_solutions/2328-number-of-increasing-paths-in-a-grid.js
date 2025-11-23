var countPaths = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dp = Array(m).fill(null).map(() => Array(n).fill(0));
    const MOD = 10**9 + 7;
    let count = 0;

    const dfs = (row, col) => {
        if (dp[row][col] !== 0) {
            return dp[row][col];
        }

        let paths = 1;
        const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

        for (const [dr, dc] of directions) {
            const newRow = row + dr;
            const newCol = col + dc;

            if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && grid[newRow][newCol] > grid[row][col]) {
                paths = (paths + dfs(newRow, newCol)) % MOD;
            }
        }

        dp[row][col] = paths;
        return paths;
    };

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            count = (count + dfs(i, j)) % MOD;
        }
    }

    return count;
};