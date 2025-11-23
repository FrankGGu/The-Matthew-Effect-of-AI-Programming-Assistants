int** pivotTable(int** mat, int matSize, int* matColSize, int* returnSize, int** returnColumnSizes) {
    int newRowCount = matColSize[0];
    int newColCount = matSize;
    int** result = (int**)malloc(newRowCount * sizeof(int*));
    *returnColumnSizes = (int*)malloc(newRowCount * sizeof(int));
    for (int i = 0; i < newRowCount; i++) {
        result[i] = (int*)malloc(newColCount * sizeof(int));
        (*returnColumnSizes)[i] = newColCount;
    }

    for (int i = 0; i < matSize; i++) {
        for (int j = 0; j < matColSize[0]; j++) {
            result[j][i] = mat[i][j];
        }
    }

    *returnSize = newRowCount;
    return result;
}