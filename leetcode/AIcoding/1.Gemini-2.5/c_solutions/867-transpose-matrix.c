int** transpose(int** matrix, int matrixSize, int* matrixColSize, int* returnSize, int** returnColumnSizes) {
    int originalRows = matrixSize;
    int originalCols = matrixColSize[0];

    int transposedRows = originalCols;
    int transposedCols = originalRows;

    int** transposedMatrix = (int**)malloc(transposedRows * sizeof(int*));
    *returnColumnSizes = (int*)malloc(transposedRows * sizeof(int));
    *returnSize = transposedRows;

    for (int i = 0; i < transposedRows; i++) {
        transposedMatrix[i] = (int*)malloc(transposedCols * sizeof(int));
        (*returnColumnSizes)[i] = transposedCols;
    }

    for (int i = 0; i < originalRows; i++) {
        for (int j = 0; j < originalCols; j++) {
            transposedMatrix[j][i] = matrix[i][j];
        }
    }

    return transposedMatrix;
}