void modifyMatrix(int** matrix, int matrixSize, int* matrixColSize) {
    int rows = matrixSize, cols = *matrixColSize;
    int** temp = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        temp[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            temp[i][j] = matrix[i][j];
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] == 0) {
                for (int k = 0; k < rows; k++) {
                    temp[k][j] = 0;
                }
                for (int k = 0; k < cols; k++) {
                    temp[i][k] = 0;
                }
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            matrix[i][j] = temp[i][j];
        }
    }

    for (int i = 0; i < rows; i++) {
        free(temp[i]);
    }
    free(temp);
}