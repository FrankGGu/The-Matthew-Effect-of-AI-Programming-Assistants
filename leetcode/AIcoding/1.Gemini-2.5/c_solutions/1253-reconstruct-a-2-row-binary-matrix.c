#include <stdlib.h>

int** reconstructMatrix(int upper, int lower, int* colsum, int colsumSize, int* returnSize, int** returnColumnSizes) {
    int n = colsumSize;

    int** result = (int**)malloc(2 * sizeof(int*));
    if (result == NULL) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }
    result[0] = (int*)malloc(n * sizeof(int));
    if (result[0] == NULL) {
        free(result);
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }
    result[1] = (int*)malloc(n * sizeof(int));
    if (result[1] == NULL) {
        free(result[0]);
        free(result);
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    for (int j = 0; j < n; j++) {
        result[0][j] = 0;
        result[1][j] = 0;
    }

    for (int j = 0; j < n; j++) {
        if (colsum[j] == 2) {
            result[0][j] = 1;
            result[1][j] = 1;
            upper--;
            lower--;
        }
    }

    if (upper < 0 || lower < 0) {
        free(result[0]);
        free(result[1]);
        free(result);
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    for (int j = 0; j < n; j++) {
        if (colsum[j] == 1) {
            if (upper > 0) {
                result[0][j] = 1;
                upper--;
            } else if (lower > 0) {
                result[1][j] = 1;
                lower--;
            } else {
                free(result[0]);
                free(result[1]);
                free(result);
                *returnSize = 0;
                *returnColumnSizes = NULL;
                return NULL;
            }
        }
    }

    if (upper != 0 || lower != 0) {
        free(result[0]);
        free(result[1]);
        free(result);
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    *returnSize = 2;
    *returnColumnSizes = (int*)malloc(2 * sizeof(int));
    if (*returnColumnSizes == NULL) {
        free(result[0]);
        free(result[1]);
        free(result);
        *returnSize = 0;
        return NULL;
    }
    (*returnColumnSizes)[0] = n;
    (*returnColumnSizes)[1] = n;

    return result;
}