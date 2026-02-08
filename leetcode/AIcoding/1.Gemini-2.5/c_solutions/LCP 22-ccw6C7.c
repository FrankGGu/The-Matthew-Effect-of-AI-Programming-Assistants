int minimumOperations(int** grid, int gridSize, int* gridColSize, int r, int c) {
    int n = gridSize;
    int operations = 0;

    for (int j = 0; j < n; j++) {
        if (grid[r][j] == 0) {
            operations++;
        }
    }

    for (int i = 0; i < n; i++) {
        if (grid[i][c] == 0) {
            operations++;
        }
    }

    if (grid[r][c] == 0) {
        operations--;
    }

    return operations;
}