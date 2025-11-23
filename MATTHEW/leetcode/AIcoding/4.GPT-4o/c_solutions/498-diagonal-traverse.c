int* diagonalTraverse(int** mat, int matSize, int* matColSize, int* returnSize) {
    if (matSize == 0 || matColSize[0] == 0) {
        *returnSize = 0;
        return NULL;
    }

    int rows = matSize, cols = matColSize[0];
    int* result = (int*)malloc(rows * cols * sizeof(int));
    int index = 0;

    for (int d = 0; d < rows + cols - 1; d++) {
        if (d % 2 == 0) {
            for (int i = d < rows ? d : rows - 1; i >= 0 && d - i < cols; i--) {
                result[index++] = mat[i][d - i];
            }
        } else {
            for (int i = 0; i <= d && i < rows; i++) {
                if (d - i < cols) {
                    result[index++] = mat[i][d - i];
                }
            }
        }
    }

    *returnSize = index;
    return result;
}