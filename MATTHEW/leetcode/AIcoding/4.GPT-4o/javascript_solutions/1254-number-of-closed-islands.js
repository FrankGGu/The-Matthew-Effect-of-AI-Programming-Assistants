var closedIsland = function(grid) {
    const m = grid.length, n = grid[0].length;

    const dfs = (x, y) => {
        if (x < 0 || x >= m || y < 0 || y >= n) return true;
        if (grid[x][y] === 1) return true;
        grid[x][y] = 1;
        let up = dfs(x - 1, y);
        let down = dfs(x + 1, y);
        let left = dfs(x, y - 1);
        let right = dfs(x, y + 1);
        return up && down && left && right;
    };

    let count = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 0) {
                if (dfs(i, j)) count++;
            }
        }
    }
    return count;
};