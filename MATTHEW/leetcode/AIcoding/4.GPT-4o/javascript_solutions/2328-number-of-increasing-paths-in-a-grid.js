var countPaths = function(grid) {
    const MOD = 1e9 + 7;
    const rows = grid.length;
    const cols = grid[0].length;
    const dp = Array.from({ length: rows }, () => Array(cols).fill(0));
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];

    const isValid = (x, y) => x >= 0 && x < rows && y >= 0 && y < cols;

    const dfs = (x, y) => {
        if (dp[x][y] !== 0) return dp[x][y];
        let count = 1;
        for (const [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;
            if (isValid(nx, ny) && grid[nx][ny] > grid[x][y]) {
                count = (count + dfs(nx, ny)) % MOD;
            }
        }
        dp[x][y] = count;
        return count;
    };

    let totalPaths = 0;
    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            totalPaths = (totalPaths + dfs(i, j)) % MOD;
        }
    }

    return totalPaths;
};