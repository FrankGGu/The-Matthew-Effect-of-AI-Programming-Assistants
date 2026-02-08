int countServers(int** grid, int gridSize, int* gridColSize) {
    int rowCount[gridSize];
    int colCount[gridColSize[0]];
    memset(rowCount, 0, sizeof(rowCount));
    memset(colCount, 0, sizeof(colCount));
    int count = 0;

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[0]; j++) {
            if (grid[i][j] == 1) {
                rowCount[i]++;
                colCount[j]++;
            }
        }
    }

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[0]; j++) {
            if (grid[i][j] == 1 && (rowCount[i] > 1 || colCount[j] > 1)) {
                count++;
            }
        }
    }

    return count;
}