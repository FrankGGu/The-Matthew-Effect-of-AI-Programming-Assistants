/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the return array are stored as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** modifiedMatrix(int** matrix, int matrixSize, int* matrixColSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = matrixSize;
    *returnColumnSizes = malloc(matrixSize * sizeof(int));
    for (int i = 0; i < matrixSize; i++) {
        (*returnColumnSizes)[i] = *matrixColSize;
    }

    int** result = malloc(matrixSize * sizeof(int*));
    for (int i = 0; i < matrixSize; i++) {
        result[i] = malloc((*matrixColSize) * sizeof(int));
        for (int j = 0; j < *matrixColSize; j++) {
            result[i][j] = matrix[i][j];
        }
    }

    for (int j = 0; j < *matrixColSize; j++) {
        int maxVal = -1;
        for (int i = 0; i < matrixSize; i++) {
            if (matrix[i][j] > maxVal) {
                maxVal = matrix[i][j];
            }
        }
        for (int i = 0; i < matrixSize; i++) {
            if (result[i][j] == -1) {
                result[i][j] = maxVal;
            }
        }
    }

    return result;
}