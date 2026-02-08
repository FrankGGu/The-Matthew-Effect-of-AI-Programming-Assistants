int **incrementSubmatrices(int** matrix, int matrixSize, int* matrixColSize, int** indices, int indicesSize, int* indicesColSize, int* returnSize, int** returnColumnSizes) {
    int **result = (int **)malloc(matrixSize * sizeof(int *));
    for (int i = 0; i < matrixSize; i++) {
        result[i] = (int *)malloc(*matrixColSize * sizeof(int));
        for (int j = 0; j < *matrixColSize; j++) {
            result[i][j] = matrix[i][j];
        }
    }

    for (int k = 0; k < indicesSize; k++) {
        for (int i = 0; i <= indices[k][0]; i++) {
            for (int j = 0; j <= indices[k][1]; j++) {
                result[i][j]++;
            }
        }
    }

    *returnSize = matrixSize;
    *returnColumnSizes = (int *)malloc(*returnSize * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = *matrixColSize;
    }

    return result;
}