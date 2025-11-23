var numEnclaves = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    function dfs(i, j) {
        if (i < 0 || i >= m || j < 0 || j >= n || grid[i][j] === 0) {
            return;
        }
        grid[i][j] = 0;
        for (const [dx, dy] of directions) {
            dfs(i + dx, j + dy);
        }
    }

    for (let i = 0; i < m; i++) {
        if (grid[i][0] === 1) {
            dfs(i, 0);
        }
        if (grid[i][n - 1] === 1) {
            dfs(i, n - 1);
        }
    }

    for (let j = 0; j < n; j++) {
        if (grid[0][j] === 1) {
            dfs(0, j);
        }
        if (grid[m - 1][j] === 1) {
            dfs(m - 1, j);
        }
    }

    let count = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                count++;
            }
        }
    }

    return count;
};