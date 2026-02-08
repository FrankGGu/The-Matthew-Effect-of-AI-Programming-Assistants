#include <stdlib.h>

int** insert(int** intervals, int intervalsSize, int* intervalsColSize, int* returnSize, int** returnColumnSizes, int* newInterval, int newIntervalSize) {
    int** result = (int**)malloc((intervalsSize + 1) * sizeof(int*));
    *returnColumnSizes = (int*)malloc((intervalsSize + 1) * sizeof(int));
    *returnSize = 0;

    int i = 0;

    while (i < intervalsSize && intervals[i][1] < newInterval[0]) {
        result[*returnSize] = intervals[i];
        (*returnSize)++;
        i++;
    }

    while (i < intervalsSize && intervals[i][0] <= newInterval[1]) {
        newInterval[0] = fmin(newInterval[0], intervals[i][0]);
        newInterval[1] = fmax(newInterval[1], intervals[i][1]);
        i++;
    }

    result[*returnSize] = newInterval;
    (*returnSize)++;

    while (i < intervalsSize) {
        result[*returnSize] = intervals[i];
        (*returnSize)++;
        i++;
    }

    *returnColumnSizes = (int*)malloc(*returnSize * sizeof(int));
    for (int j = 0; j < *returnSize; j++) {
        (*returnColumnSizes)[j] = 2;
    }

    return result;
}