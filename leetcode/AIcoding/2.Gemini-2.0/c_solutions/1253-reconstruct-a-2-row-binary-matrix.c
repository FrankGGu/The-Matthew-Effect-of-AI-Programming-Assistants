#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** reconstructMatrix(int upper, int lower, int* colsum, int colsumSize, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(2 * sizeof(int*));
    result[0] = (int*)malloc(colsumSize * sizeof(int));
    result[1] = (int*)malloc(colsumSize * sizeof(int));

    int upper_used = 0;
    int lower_used = 0;

    for (int i = 0; i < colsumSize; i++) {
        if (colsum[i] == 2) {
            result[0][i] = 1;
            result[1][i] = 1;
            upper_used++;
            lower_used++;
        } else if (colsum[i] == 0) {
            result[0][i] = 0;
            result[1][i] = 0;
        }
    }

    for (int i = 0; i < colsumSize; i++) {
        if (colsum[i] == 1) {
            if (upper_used < upper) {
                result[0][i] = 1;
                result[1][i] = 0;
                upper_used++;
            } else if (lower_used < lower) {
                result[0][i] = 0;
                result[1][i] = 1;
                lower_used++;
            } else {
                free(result[0]);
                free(result[1]);
                free(result);
                *returnSize = 0;
                return NULL;
            }
        }
    }

    if (upper_used != upper || lower_used != lower) {
        free(result[0]);
        free(result[1]);
        free(result);
        *returnSize = 0;
        return NULL;
    }

    *returnSize = 2;
    *returnColumnSizes = (int*)malloc(2 * sizeof(int));
    (*returnColumnSizes)[0] = colsumSize;
    (*returnColumnSizes)[1] = colsumSize;

    return result;
}