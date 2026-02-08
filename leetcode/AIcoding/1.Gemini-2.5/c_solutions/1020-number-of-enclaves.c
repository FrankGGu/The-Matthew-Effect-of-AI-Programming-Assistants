void dfs(int** grid, int r, int c, int m, int n) {
    if (r < 0 || r >= m || c < 0 || c >= n || grid[r][c] == 0) {
        return;
    }

    grid[r][c] = 0;

    dfs(grid, r + 1, c, m, n);
    dfs(grid, r - 1, c, m, n);
    dfs(grid, r, c + 1, m, n);
    dfs(grid, r, c - 1, m, n);
}

int numEnclaves(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    if (m == 0) return 0;
    int n = gridColSize[0];
    if (n == 0) return 0;

    for (int c = 0; c < n; c++) {
        if (grid[0][c] == 1) {
            dfs(grid, 0, c, m, n);
        }
        if (grid[m - 1][c] == 1) {
            dfs(grid, m - 1, c, m, n);
        }
    }

    for (int r = 0; r < m; r++) {
        if (grid[r][0] == 1) {
            dfs(grid, r, 0, m, n);
        }
        if (grid[r][n - 1] == 1) {
            dfs(grid, r, n - 1, m, n);
        }
    }

    int enclaves = 0;
    for (int r = 0; r < m; r++) {
        for (int c = 0; c < n; c++) {
            if (grid[r][c] == 1) {
                enclaves++;
            }
        }
    }

    return enclaves;
}