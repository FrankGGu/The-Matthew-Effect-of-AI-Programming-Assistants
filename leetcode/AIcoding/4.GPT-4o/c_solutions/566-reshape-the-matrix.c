int** matrixReshape(int** mat, int matSize, int* matColSize, int r, int c, int* returnSize, int** returnColumnSizes) {
    if (matSize * (*matColSize) != r * c) {
        *returnSize = matSize;
        *returnColumnSizes = matColSize;
        return mat;
    }

    int** reshaped = (int**)malloc(r * sizeof(int*));
    for (int i = 0; i < r; i++) {
        reshaped[i] = (int*)malloc(c * sizeof(int));
    }

    for (int i = 0; i < matSize; i++) {
        for (int j = 0; j < *matColSize; j++) {
            int index = i * (*matColSize) + j;
            reshaped[index / c][index % c] = mat[i][j];
        }
    }

    *returnSize = r;
    *returnColumnSizes = (int*)malloc(r * sizeof(int));
    for (int i = 0; i < r; i++) {
        (*returnColumnSizes)[i] = c;
    }

    return reshaped;
}