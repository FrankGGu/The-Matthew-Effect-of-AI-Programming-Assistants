int countUnguarded(int m, int n, int** guards, int guardsSize, int* guardsColSize, int** walls, int wallsSize, int* wallsColSize) {
    int grid[m][n];
    memset(grid, 0, sizeof(grid));

    for (int i = 0; i < guardsSize; i++) {
        grid[guards[i][0]][guards[i][1]] = 1;
    }

    for (int i = 0; i < wallsSize; i++) {
        grid[walls[i][0]][walls[i][1]] = 2;
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                for (int k = i; k < m && grid[k][j] != 2; k++) grid[k][j] = 3;
                for (int k = i; k >= 0 && grid[k][j] != 2; k--) grid[k][j] = 3;
                for (int k = j; k < n && grid[i][k] != 2; k++) grid[i][k] = 3;
                for (int k = j; k >= 0 && grid[i][k] != 2; k--) grid[i][k] = 3;
            }
        }
    }

    int count = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 0) count++;
        }
    }

    return count;
}