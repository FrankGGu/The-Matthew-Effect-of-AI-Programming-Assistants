function countPaths(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dp = Array.from({ length: m }, () => Array(n).fill(0));
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    function dfs(i, j) {
        if (dp[i][j] !== 0) return dp[i][j];

        let count = 1;
        for (const [dx, dy] of directions) {
            const x = i + dx;
            const y = j + dy;
            if (x >= 0 && x < m && y >= 0 && y < n && grid[x][y] > grid[i][j]) {
                count += dfs(x, y);
            }
        }

        dp[i][j] = count;
        return count;
    }

    let total = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            total += dfs(i, j);
        }
    }

    return total;
}