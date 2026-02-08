int* luckyNumbers (int** matrix, int matrixSize, int* matrixColSize, int* returnSize){
    int* result = (int*)malloc(0);
    *returnSize = 0;

    for (int i = 0; i < matrixSize; i++) {
        int minRow = matrix[i][0], colIdx = 0;
        for (int j = 1; j < matrixColSize[i]; j++) {
            if (matrix[i][j] < minRow) {
                minRow = matrix[i][j];
                colIdx = j;
            }
        }

        int maxCol = matrix[0][colIdx];
        for (int k = 1; k < matrixSize; k++) {
            if (matrix[k][colIdx] > maxCol) {
                maxCol = matrix[k][colIdx];
            }
        }

        if (minRow == maxCol) {
            result = (int*)realloc(result, (*returnSize + 1) * sizeof(int));
            result[*returnSize] = minRow;
            (*returnSize)++;
        }
    }

    return result;
}