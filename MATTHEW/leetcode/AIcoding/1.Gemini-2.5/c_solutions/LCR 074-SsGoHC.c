#include <stdlib.h> // For malloc, realloc, free, qsort

int compareIntervals(const void* a, const void* b) {
    const int* intervalA = *(const int**)a;
    const int* intervalB = *(const int**)b;
    if (intervalA[0] != intervalB[0]) {
        return intervalA[0] - intervalB[0];
    }
    return intervalA[1] - intervalB[1];
}

int** merge(int** intervals, int intervalsSize, int* intervalsColSize, int* returnSize, int** returnColumnSizes) {
    if (intervalsSize == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    qsort(intervals, intervalsSize, sizeof(int*), compareIntervals);

    int** mergedIntervals = (int**)malloc(intervalsSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(intervalsSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < intervalsSize; ++i) {
        if (*returnSize == 0 || intervals[i][0] > mergedIntervals[*returnSize - 1][1]) {
            mergedIntervals[*returnSize] = (int*)malloc(2 * sizeof(int));
            mergedIntervals[*returnSize][0] = intervals[i][0];
            mergedIntervals[*returnSize][1] = intervals[i][1];
            (*returnColumnSizes)[*returnSize] = 2;
            (*returnSize)++;
        } else {
            if (intervals[i][1] > mergedIntervals[*returnSize - 1][1]) {
                mergedIntervals[*returnSize - 1][1] = intervals[i][1];
            }
        }
    }

    if (*returnSize < intervalsSize) {
        mergedIntervals = (int**)realloc(mergedIntervals, (*returnSize) * sizeof(int*));
        *returnColumnSizes = (int*)realloc(*returnColumnSizes, (*returnSize) * sizeof(int));
    }

    return mergedIntervals;
}