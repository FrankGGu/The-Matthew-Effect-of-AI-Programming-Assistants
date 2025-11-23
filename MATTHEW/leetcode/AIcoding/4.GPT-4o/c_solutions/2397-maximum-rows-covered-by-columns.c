int maximumRows(int** matrix, int matrixSize, int* matrixColSize, int numSelect) {
    int maxRows = 0;
    int rows = matrixSize;
    int cols = *matrixColSize;

    for (int mask = 0; mask < (1 << cols); mask++) {
        if (__builtin_popcount(mask) != numSelect) continue;

        int coveredRows = 0;
        for (int i = 0; i < rows; i++) {
            int isCovered = 1;
            for (int j = 0; j < cols; j++) {
                if (matrix[i][j] == 1 && !(mask & (1 << j))) {
                    isCovered = 0;
                    break;
                }
            }
            coveredRows += isCovered;
        }
        maxRows = fmax(maxRows, coveredRows);
    }

    return maxRows;
}