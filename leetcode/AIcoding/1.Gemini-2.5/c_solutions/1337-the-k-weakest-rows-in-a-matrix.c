#include <stdlib.h>

typedef struct {
    int soldiers;
    int index;
} RowInfo;

int compareRows(const void *a, const void *b) {
    RowInfo *rowA = (RowInfo *)a;
    RowInfo *rowB = (RowInfo *)b;

    if (rowA->soldiers != rowB->soldiers) {
        return rowA->soldiers - rowB->soldiers;
    }
    return rowA->index - rowB->index;
}

int countSoldiersInRow(int* row, int colSize) {
    int count = 0;
    for (int j = 0; j < colSize; j++) {
        if (row[j] == 1) {
            count++;
        } else {
            break;
        }
    }
    return count;
}

int* kWeakestRows(int** mat, int matSize, int* matColSize, int k, int* returnSize) {
    int n = matColSize[0];

    RowInfo* rowInfos = (RowInfo*)malloc(matSize * sizeof(RowInfo));

    for (int i = 0; i < matSize; i++) {
        rowInfos[i].soldiers = countSoldiersInRow(mat[i], n);
        rowInfos[i].index = i;
    }

    qsort(rowInfos, matSize, sizeof(RowInfo), compareRows);

    int* result = (int*)malloc(k * sizeof(int));

    for (int i = 0; i < k; i++) {
        result[i] = rowInfos[i].index;
    }

    *returnSize = k;

    free(rowInfos);

    return result;
}