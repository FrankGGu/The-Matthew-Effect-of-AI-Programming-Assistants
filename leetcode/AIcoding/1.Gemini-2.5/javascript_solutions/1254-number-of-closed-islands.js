var numClosedIslands = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const dfs = (r, c) => {
        if (r < 0 || r >= m || c < 0 || c >= n || grid[r][c] === 1) {
            return;
        }
        grid[r][c] = 1;
        dfs(r + 1, c);
        dfs(r - 1, c);
        dfs(r, c + 1);
        dfs(r, c - 1);
    };

    for (let c = 0; c < n; c++) {
        if (grid[0][c] === 0) {
            dfs(0, c);
        }
        if (grid[m - 1][c] === 0) {
            dfs(m - 1, c);
        }
    }

    for (let r = 1; r < m - 1; r++) {
        if (grid[r][0] === 0) {
            dfs(r, 0);
        }
        if (grid[r][n - 1] === 0) {
            dfs(r, n - 1);
        }
    }

    let closedIslands = 0;
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (grid[r][c] === 0) {
                closedIslands++;
                dfs(r, c);
            }
        }
    }

    return closedIslands;
};