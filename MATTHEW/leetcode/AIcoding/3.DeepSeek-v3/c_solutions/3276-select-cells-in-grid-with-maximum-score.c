int maxScore;

void backtrack(int** grid, int gridSize, int* gridColSize, int row, int* colUsed, int* rowUsed, int currentScore, int startCol) {
    if (row == gridSize) {
        if (currentScore > maxScore) {
            maxScore = currentScore;
        }
        return;
    }

    for (int col = startCol; col < gridColSize[row]; col++) {
        if (grid[row][col] == 1 && !colUsed[col] && !rowUsed[row]) {
            colUsed[col] = 1;
            rowUsed[row] = 1;
            backtrack(grid, gridSize, gridColSize, row + 1, colUsed, rowUsed, currentScore + 1, 0);
            colUsed[col] = 0;
            rowUsed[row] = 0;
        }
    }

    backtrack(grid, gridSize, gridColSize, row + 1, colUsed, rowUsed, currentScore, 0);
}

int maximumScore(int** grid, int gridSize, int* gridColSize) {
    maxScore = 0;
    int maxCol = 0;
    for (int i = 0; i < gridSize; i++) {
        if (gridColSize[i] > maxCol) {
            maxCol = gridColSize[i];
        }
    }

    int* colUsed = (int*)calloc(maxCol, sizeof(int));
    int* rowUsed = (int*)calloc(gridSize, sizeof(int));

    backtrack(grid, gridSize, gridColSize, 0, colUsed, rowUsed, 0, 0);

    free(colUsed);
    free(rowUsed);

    return maxScore;
}