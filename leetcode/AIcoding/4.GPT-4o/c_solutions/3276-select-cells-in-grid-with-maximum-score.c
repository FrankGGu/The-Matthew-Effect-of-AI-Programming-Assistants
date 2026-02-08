int maxScore(int** grid, int gridSize, int* gridColSize) {
    int maxRow = gridSize;
    int maxCol = gridColSize[0];
    int maxScore = 0;
    int row, col;

    for (row = 0; row < maxRow; row++) {
        for (col = 0; col < maxCol; col++) {
            int currentScore = 0;
            for (int r = row; r < maxRow; r++) {
                for (int c = col; c < maxCol; c++) {
                    currentScore += grid[r][c];
                }
            }
            if (currentScore > maxScore) {
                maxScore = currentScore;
            }
        }
    }

    return maxScore;
}