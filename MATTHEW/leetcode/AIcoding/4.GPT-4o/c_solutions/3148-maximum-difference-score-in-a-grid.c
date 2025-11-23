int maxDifference(int** grid, int gridSize, int* gridColSize) {
    int maxScore = 0;
    int minVal = grid[0][0];
    int maxVal = grid[0][0];

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] > maxVal) {
                maxVal = grid[i][j];
            }
            if (grid[i][j] < minVal) {
                minVal = grid[i][j];
            }
        }
    }

    maxScore = maxVal - minVal;
    return maxScore;
}