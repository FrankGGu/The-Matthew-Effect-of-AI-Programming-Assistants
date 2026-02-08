int closedIsland(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];
    int count = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 0) {
                if (dfs(grid, i, j, m, n)) {
                    count++;
                }
            }
        }
    }
    return count;
}

bool dfs(int** grid, int i, int j, int m, int n) {
    if (i < 0 || i >= m || j < 0 || j >= n) return false;
    if (grid[i][j] == 1) return true;

    grid[i][j] = 1;

    bool d1 = dfs(grid, i+1, j, m, n);
    bool d2 = dfs(grid, i-1, j, m, n);
    bool d3 = dfs(grid, i, j+1, m, n);
    bool d4 = dfs(grid, i, j-1, m, n);

    return d1 && d2 && d3 && d4;
}