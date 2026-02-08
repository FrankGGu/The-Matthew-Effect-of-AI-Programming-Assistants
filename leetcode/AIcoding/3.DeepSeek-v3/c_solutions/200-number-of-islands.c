int numIslands(char** grid, int gridSize, int* gridColSize) {
    if (gridSize == 0 || gridColSize[0] == 0) return 0;

    int count = 0;
    int rows = gridSize;
    int cols = gridColSize[0];

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == '1') {
                count++;
                dfs(grid, i, j, rows, cols);
            }
        }
    }

    return count;
}

void dfs(char** grid, int i, int j, int rows, int cols) {
    if (i < 0 || i >= rows || j < 0 || j >= cols || grid[i][j] != '1') {
        return;
    }

    grid[i][j] = '0';

    dfs(grid, i + 1, j, rows, cols);
    dfs(grid, i - 1, j, rows, cols);
    dfs(grid, i, j + 1, rows, cols);
    dfs(grid, i, j - 1, rows, cols);
}