int** spiralMatrix(int rows, int cols, int** mat, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            result[i][j] = 0;
        }
    }

    int r1 = 0, r2 = rows - 1, c1 = 0, c2 = cols - 1;
    int num = 1;

    while (r1 <= r2 && c1 <= c2) {
        for (int c = c1; c <= c2; c++) {
            result[r1][c] = num++;
        }
        r1++;
        for (int r = r1; r <= r2; r++) {
            result[r][c2] = num++;
        }
        c2--;
        if (r1 <= r2) {
            for (int c = c2; c >= c1; c--) {
                result[r2][c] = num++;
            }
            r2--;
        }
        if (c1 <= c2) {
            for (int r = r2; r >= r1; r--) {
                result[r][c1] = num++;
            }
            c1++;
        }
    }

    *returnSize = rows;
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        (*returnColumnSizes)[i] = cols;
    }

    return result;
}