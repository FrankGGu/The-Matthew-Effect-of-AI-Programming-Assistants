int minFallingPathSum(int** matrix, int matrixSize, int* matrixColSize) {
    for (int i = 1; i < matrixSize; i++) {
        for (int j = 0; j < matrixColSize[0]; j++) {
            int minAbove = matrix[i-1][j];
            if (j > 0) minAbove = fmin(minAbove, matrix[i-1][j-1]);
            if (j < matrixColSize[0] - 1) minAbove = fmin(minAbove, matrix[i-1][j+1]);
            matrix[i][j] += minAbove;
        }
    }
    int minPathSum = matrix[0][0];
    for (int j = 1; j < matrixColSize[0]; j++) {
        minPathSum = fmin(minPathSum, matrix[matrixSize-1][j]);
    }
    return minPathSum;
}