int countBlackBlocks(int m, int n, int[][] coordinates) {
    int grid[100][100] = {0};
    int count = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            grid[i][j] = 0;
        }
    }

    for (int i = 0; i < coordinatesSize; i++) {
        int x = coordinates[i][0];
        int y = coordinates[i][1];
        grid[x][y] = 1;
    }

    for (int i = 0; i < m - 1; i++) {
        for (int j = 0; j < n - 1; j++) {
            if (grid[i][j] + grid[i][j + 1] + grid[i + 1][j] + grid[i + 1][j + 1] >= 1) {
                count++;
            }
        }
    }

    return count;
}