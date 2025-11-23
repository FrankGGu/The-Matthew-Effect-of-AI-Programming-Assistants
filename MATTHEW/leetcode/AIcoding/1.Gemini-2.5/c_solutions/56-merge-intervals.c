#include <stdlib.h>

int compareIntervals(const void* a, const void* b) {
    int* intervalA = *(int**)a;
    int* intervalB = *(int**)b;
    return intervalA[0] - intervalB[0];
}

int max(int a, int b) {
    return a > b ? a : b;
}

int** merge(int** intervals, int intervalsSize, int* intervalsColSize, int* returnSize, int** returnColumnSizes) {
    if (intervalsSize == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    qsort(intervals, intervalsSize, sizeof(int*), compareIntervals);

    int** merged = (int**)malloc(intervalsSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(intervalsSize * sizeof(int));
    int mergedCount = 0;

    for (int i = 0; i < intervalsSize; i++) {
        if (mergedCount == 0 || intervals[i][0] > merged[mergedCount - 1][1]) {
            merged[mergedCount] = (int*)malloc(2 * sizeof(int));
            merged[mergedCount][0] = intervals[i][0];
            merged[mergedCount][1] = intervals[i][1];
            (*returnColumnSizes)[mergedCount] = 2;
            mergedCount++;
        } else {
            merged[mergedCount - 1][1] = max(merged[mergedCount - 1][1], intervals[i][1]);
        }
    }

    *returnSize = mergedCount;

    merged = (int**)realloc(merged, mergedCount * sizeof(int*));
    *returnColumnSizes = (int*)realloc(*returnColumnSizes, mergedCount * sizeof(int));

    return merged;
}