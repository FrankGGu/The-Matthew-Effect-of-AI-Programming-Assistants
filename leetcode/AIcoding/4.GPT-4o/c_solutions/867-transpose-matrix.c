void transpose(int** A, int ASize, int* AColSize, int** returnSize) {
    int cols = ASize;
    int rows = *AColSize;
    *returnSize = malloc(sizeof(int));
    **returnSize = rows;
    int** result = malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        result[i] = malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            result[i][j] = A[j][i];
        }
    }
    return result;
}