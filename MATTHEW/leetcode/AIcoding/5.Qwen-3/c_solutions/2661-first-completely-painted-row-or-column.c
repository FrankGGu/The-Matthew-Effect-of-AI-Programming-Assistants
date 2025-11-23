#include <stdio.h>
#include <stdlib.h>

int* firstCompleteKey(int* arr, int arrSize, int** mat, int matSize, int* matColSize, int* returnSize) {
    int* row = (int*)calloc(matSize, sizeof(int));
    int* col = (int*)calloc(matColSize[0], sizeof(int));
    int* map = (int*)calloc(matSize * matColSize[0], sizeof(int));
    int i, j, k;

    for (i = 0; i < matSize; i++) {
        for (j = 0; j < matColSize[0]; j++) {
            map[mat[i][j]] = i * matColSize[0] + j;
        }
    }

    for (k = 0; k < arrSize; k++) {
        int val = arr[k];
        int pos = map[val];
        i = pos / matColSize[0];
        j = pos % matColSize[0];
        row[i]++;
        col[j]++;
        if (row[i] == matColSize[0] || col[j] == matSize) {
            int* result = (int*)malloc(2 * sizeof(int));
            result[0] = i;
            result[1] = j;
            *returnSize = 2;
            free(row);
            free(col);
            free(map);
            return result;
        }
    }

    free(row);
    free(col);
    free(map);
    *returnSize = 0;
    return NULL;
}