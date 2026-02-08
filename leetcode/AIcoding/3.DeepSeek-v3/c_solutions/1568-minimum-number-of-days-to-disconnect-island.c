int minDays(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];

    if (countIslands(grid, rows, cols) != 1) {
        return 0;
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                grid[i][j] = 0;
                if (countIslands(grid, rows, cols) != 1) {
                    return 1;
                }
                grid[i][j] = 1;
            }
        }
    }

    return 2;
}

int countIslands(int** grid, int rows, int cols) {
    int** visited = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (int*)malloc(cols * sizeof(int));
        memset(visited[i], 0, cols * sizeof(int));
    }

    int count = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1 && !visited[i][j]) {
                count++;
                dfs(grid, visited, i, j, rows, cols);
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        free(visited[i]);
    }
    free(visited);

    return count;
}

void dfs(int** grid, int** visited, int i, int j, int rows, int cols) {
    if (i < 0 || i >= rows || j < 0 || j >= cols || grid[i][j] == 0 || visited[i][j]) {
        return;
    }

    visited[i][j] = 1;

    dfs(grid, visited, i + 1, j, rows, cols);
    dfs(grid, visited, i - 1, j, rows, cols);
    dfs(grid, visited, i, j + 1, rows, cols);
    dfs(grid, visited, i, j - 1, rows, cols);
}