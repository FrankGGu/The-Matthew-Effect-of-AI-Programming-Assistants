bool checkValid(int** matrix, int matrixSize, int* matrixColSize) {
    for (int i = 0; i < matrixSize; i++) {
        int* rowCheck = (int*)calloc(matrixSize + 1, sizeof(int));
        int* colCheck = (int*)calloc(matrixSize + 1, sizeof(int));

        for (int j = 0; j < matrixSize; j++) {
            if (matrix[i][j] < 1 || matrix[i][j] > matrixSize || rowCheck[matrix[i][j]] != 0) {
                free(rowCheck);
                free(colCheck);
                return false;
            }
            rowCheck[matrix[i][j]] = 1;

            if (matrix[j][i] < 1 || matrix[j][i] > matrixSize || colCheck[matrix[j][i]] != 0) {
                free(rowCheck);
                free(colCheck);
                return false;
            }
            colCheck[matrix[j][i]] = 1;
        }

        free(rowCheck);
        free(colCheck);
    }
    return true;
}