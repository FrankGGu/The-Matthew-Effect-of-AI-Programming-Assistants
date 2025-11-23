int countSquares(int** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || matrixColSize == NULL || matrixColSize[0] == 0) {
        return 0;
    }

    int rows = matrixSize;
    int cols = matrixColSize[0];

    int total_squares = 0;

    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            if (matrix[i][j] == 1 && i > 0 && j > 0) {
                int val1 = matrix[i-1][j];
                int val2 = matrix[i][j-1];
                int val3 = matrix[i-1][j-1];

                int min_val = val1 < val2 ? val1 : val2;
                min_val = min_val < val3 ? min_val : val3;

                matrix[i][j] = 1 + min_val;
            }
            total_squares += matrix[i][j];
        }
    }

    return total_squares;
}