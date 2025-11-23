#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return ((int**)a)[0][0] - ((int**)b)[0][0];
}

int** merge(int** intervals, int intervalsSize, int* intervalsColSize, int* returnSize, int** returnColumnSizes){
    if (intervalsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    qsort(intervals, intervalsSize, sizeof(int*), compare);

    int** merged = (int**)malloc(intervalsSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(intervalsSize * sizeof(int));
    int mergedSize = 0;

    merged[mergedSize] = (int*)malloc(2 * sizeof(int));
    merged[mergedSize][0] = intervals[0][0];
    merged[mergedSize][1] = intervals[0][1];
    (*returnColumnSizes)[mergedSize] = 2;
    mergedSize++;

    for (int i = 1; i < intervalsSize; i++) {
        if (intervals[i][0] <= merged[mergedSize - 1][1]) {
            merged[mergedSize - 1][1] = (intervals[i][1] > merged[mergedSize - 1][1]) ? intervals[i][1] : merged[mergedSize - 1][1];
        } else {
            merged[mergedSize] = (int*)malloc(2 * sizeof(int));
            merged[mergedSize][0] = intervals[i][0];
            merged[mergedSize][1] = intervals[i][1];
            (*returnColumnSizes)[mergedSize] = 2;
            mergedSize++;
        }
    }

    *returnSize = mergedSize;
    return merged;
}