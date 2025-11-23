int** reconstructMatrix(int upper, int lower, int* colsum, int colsumSize, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(2 * sizeof(int*));
    for (int i = 0; i < 2; i++) {
        result[i] = (int*)malloc(colsumSize * sizeof(int));
    }
    *returnSize = 2;
    *returnColumnSizes = (int*)malloc(2 * sizeof(int));
    (*returnColumnSizes)[0] = colsumSize;
    (*returnColumnSizes)[1] = colsumSize;

    for (int i = 0; i < colsumSize; i++) {
        if (colsum[i] == 2) {
            if (upper > 0 && lower > 0) {
                result[0][i] = 1;
                result[1][i] = 1;
                upper--;
                lower--;
            } else {
                free(result[0]);
                free(result[1]);
                free(result);
                return NULL;
            }
        } else if (colsum[i] == 1) {
            if (upper > 0) {
                result[0][i] = 1;
                result[1][i] = 0;
                upper--;
            } else if (lower > 0) {
                result[0][i] = 0;
                result[1][i] = 1;
                lower--;
            } else {
                free(result[0]);
                free(result[1]);
                free(result);
                return NULL;
            }
        } else {
            result[0][i] = 0;
            result[1][i] = 0;
        }
    }

    return result;
}