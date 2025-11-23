#include <stdlib.h>

typedef struct {
    int index;
    int soldiers;
} Row;

int cmp(const void *a, const void *b) {
    Row *rowA = (Row *)a;
    Row *rowB = (Row *)b;
    if (rowA->soldiers == rowB->soldiers) {
        return rowA->index - rowB->index;
    }
    return rowA->soldiers - rowB->soldiers;
}

int* kWeakestRows(int** mat, int matSize, int* matColSize, int k, int* returnSize) {
    Row *rows = (Row *)malloc(matSize * sizeof(Row));
    for (int i = 0; i < matSize; i++) {
        rows[i].index = i;
        rows[i].soldiers = 0;
        for (int j = 0; j < matColSize[i]; j++) {
            if (mat[i][j] == 1) {
                rows[i].soldiers++;
            } else {
                break;
            }
        }
    }

    qsort(rows, matSize, sizeof(Row), cmp);

    int *result = (int *)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        result[i] = rows[i].index;
    }

    free(rows);
    *returnSize = k;
    return result;
}