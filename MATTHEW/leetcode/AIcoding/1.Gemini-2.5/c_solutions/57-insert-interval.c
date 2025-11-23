#include <stdlib.h> // For malloc

static int int_min(int a, int b) {
    return (a < b) ? a : b;
}

static int int_max(int a, int b) {
    return (a > b) ? a : b;
}

int** insert(int** intervals, int intervalsSize, int* intervalsColSize, int* newInterval, int newIntervalSize, int* returnSize, int** returnColumnSizes) {
    // Allocate maximum possible space for the result.
    // The result can have at most intervalsSize + 1 intervals (if newInterval doesn't overlap with any existing).
    int** result = (int**)malloc(sizeof(int*) * (intervalsSize + 1));
    *returnColumnSizes = (int*)malloc(sizeof(int) * (intervalsSize + 1));
    *returnSize = 0;

    int i = 0;

    // Phase 1: Add all intervals that come completely before newInterval
    // An interval [a,b] comes before [c,d] if b < c.
    while (i < intervalsSize && intervals[i][1] < newInterval[0]) {
        result[*returnSize] = (int*)malloc(sizeof(int) * 2);
        result[*returnSize][0] = intervals[i][0];
        result[*returnSize][1] = intervals[i][1];
        (*returnColumnSizes)[*returnSize] = 2;
        (*returnSize)++;
        i++;
    }

    // Phase 2: Merge newInterval with all overlapping intervals
    // An interval [a,b] overlaps with [c,d] if a <= d && b >= c.
    // Since intervals are sorted and we've processed intervals completely before newInterval,
    // we only need to check if intervals[i][0] <= newInterval[1].
    while (i < intervalsSize && intervals[i][0] <= newInterval[1]) {
        // Overlap detected, merge newInterval with the current interval
        newInterval[0] = int_min(newInterval[0], intervals[i][0]);
        newInterval[1] = int_max(newInterval[1], intervals[i][1]);
        i++;
    }

    // Add the (potentially merged) newInterval to the result
    result[*returnSize] = (int*)malloc(sizeof(int) * 2);
    result[*returnSize][0] = newInterval[0];
    result[*returnSize][1] = newInterval[1];
    (*returnColumnSizes)[*returnSize] = 2;
    (*returnSize)++;

    // Phase 3: Add all intervals that come completely after the merged newInterval
    while (i < intervalsSize) {
        result[*returnSize] = (int*)malloc(sizeof(int) * 2);
        result[*returnSize][0] = intervals[i][0];
        result[*returnSize][1] = intervals[i][1];
        (*returnColumnSizes)[*returnSize] = 2;
        (*returnSize)++;
        i++;
    }

    return result;
}