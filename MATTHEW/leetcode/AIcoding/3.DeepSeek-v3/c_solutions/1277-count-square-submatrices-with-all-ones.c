int countSquares(int** matrix, int matrixSize, int* matrixColSize) {
    int m = matrixSize;
    int n = matrixColSize[0];
    int count = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (matrix[i][j] == 1) {
                if (i > 0 && j > 0) {
                    matrix[i][j] = 1 + fmin(matrix[i-1][j-1], fmin(matrix[i-1][j], matrix[i][j-1]));
                }
                count += matrix[i][j];
            }
        }
    }

    return count;
}