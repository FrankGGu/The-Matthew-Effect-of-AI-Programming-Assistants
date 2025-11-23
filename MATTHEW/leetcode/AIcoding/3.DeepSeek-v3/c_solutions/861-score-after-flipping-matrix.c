int matrixScore(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];

    for (int i = 0; i < rows; i++) {
        if (grid[i][0] == 0) {
            for (int j = 0; j < cols; j++) {
                grid[i][j] = 1 - grid[i][j];
            }
        }
    }

    for (int j = 1; j < cols; j++) {
        int countOnes = 0;
        for (int i = 0; i < rows; i++) {
            if (grid[i][j] == 1) {
                countOnes++;
            }
        }
        if (countOnes < rows - countOnes) {
            for (int i = 0; i < rows; i++) {
                grid[i][j] = 1 - grid[i][j];
            }
        }
    }

    int score = 0;
    for (int i = 0; i < rows; i++) {
        int rowValue = 0;
        for (int j = 0; j < cols; j++) {
            rowValue = (rowValue << 1) | grid[i][j];
        }
        score += rowValue;
    }

    return score;
}