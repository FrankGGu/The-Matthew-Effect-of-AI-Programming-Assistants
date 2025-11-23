int dfs(int** grid, int rows, int cols, int x, int y, int empty) {
    if (x < 0 || x >= rows || y < 0 || y >= cols || grid[x][y] == -1) {
        return 0;
    }

    if (grid[x][y] == 2) {
        return empty == 0 ? 1 : 0;
    }

    grid[x][y] = -1;
    int paths = 0;

    paths += dfs(grid, rows, cols, x + 1, y, empty - 1);
    paths += dfs(grid, rows, cols, x - 1, y, empty - 1);
    paths += dfs(grid, rows, cols, x, y + 1, empty - 1);
    paths += dfs(grid, rows, cols, x, y - 1, empty - 1);

    grid[x][y] = 0;
    return paths;
}

int uniquePathsIII(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int start_x = 0, start_y = 0;
    int empty = 1;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                start_x = i;
                start_y = j;
            } else if (grid[i][j] == 0) {
                empty++;
            }
        }
    }

    return dfs(grid, rows, cols, start_x, start_y, empty);
}