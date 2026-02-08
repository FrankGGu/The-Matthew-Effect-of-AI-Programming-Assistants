int countCells(char ** grid, int gridSize, int * gridColSize) {
    int rowCount[100] = {0}, colCount[100] = {0};
    int count = 0;

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] == '1') {
                rowCount[i]++;
                colCount[j]++;
            }
        }
    }

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] == '1' && (rowCount[i] > 1 || colCount[j] > 1)) {
                count++;
            }
        }
    }

    return count;
}