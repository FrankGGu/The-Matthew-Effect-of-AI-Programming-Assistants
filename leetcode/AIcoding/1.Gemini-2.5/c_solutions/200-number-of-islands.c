void dfs(char** grid, int rows, int cols, int r, int c) {
    if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == '0') {
        return;
    }

    grid[r][c] = '0'; // Mark as visited

    dfs(grid, rows, cols, r + 1, c);
    dfs(grid, rows, cols, r - 1, c);
    dfs(grid, rows, cols, r, c + 1);
    dfs(grid, rows, cols, r, c - 1);
}

int numIslands(char** grid, int gridSize, int* gridColSize) {
    if (gridSize == 0 || gridColSize == NULL || gridColSize[0] == 0) {
        return 0;
    }

    int rows = gridSize;
    int cols = gridColSize[0];
    int num_islands = 0;

    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            if (grid[r][c] == '1') {
                num_islands++;
                dfs(grid, rows, cols, r, c);
            }
        }
    }

    return num_islands;
}