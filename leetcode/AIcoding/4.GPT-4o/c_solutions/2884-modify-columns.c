void modifyColumns(int** matrix, int matrixSize, int* matrixColSize) {
    for (int j = 0; j < *matrixColSize; j++) {
        int minVal = matrix[0][j];
        int maxVal = matrix[0][j];

        for (int i = 0; i < matrixSize; i++) {
            if (matrix[i][j] < minVal) {
                minVal = matrix[i][j];
            }
            if (matrix[i][j] > maxVal) {
                maxVal = matrix[i][j];
            }
        }

        for (int i = 0; i < matrixSize; i++) {
            if (matrix[i][j] == minVal) {
                matrix[i][j] = maxVal;
            } else if (matrix[i][j] == maxVal) {
                matrix[i][j] = minVal;
            }
        }
    }
}