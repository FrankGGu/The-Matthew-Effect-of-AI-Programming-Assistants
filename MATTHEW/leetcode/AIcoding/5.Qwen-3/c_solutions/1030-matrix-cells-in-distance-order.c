#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    return (x[0] + x[1]) - (y[0] + y[1]);
}

int** allCellsDistOrder(int R, int C, int** result, int* returnSize, int** returnColumnSizes) {
    *result = (int *)malloc(R * C * sizeof(int));
    *returnColumnSizes = (int *)malloc(R * C * sizeof(int));
    int index = 0;
    for (int r = 0; r < R; r++) {
        for (int c = 0; c < C; c++) {
            (*result)[index] = r * C + c;
            (*returnColumnSizes)[index++] = 2;
        }
    }
    *returnSize = R * C;
    qsort(*result, R * C, sizeof(int), cmp);
    return result;
}