int countServers(int** grid, int gridSize, int* gridColSize) {
    int rows[gridSize];
    int cols[gridColSize[0]];
    memset(rows, 0, sizeof(rows));
    memset(cols, 0, sizeof(cols));

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[0]; j++) {
            if (grid[i][j] == 1) {
                rows[i]++;
                cols[j]++;
            }
        }
    }

    int count = 0;
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[0]; j++) {
            if (grid[i][j] == 1 && (rows[i] > 1 || cols[j] > 1)) {
                count++;
            }
        }
    }

    return count;
}