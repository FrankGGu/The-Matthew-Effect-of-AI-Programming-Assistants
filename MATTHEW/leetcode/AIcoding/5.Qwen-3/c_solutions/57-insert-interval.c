#include <stdio.h>
#include <stdlib.h>

int** insert(int** intervals, int intervalsSize, int* newInterval, int newIntervalSize, int* returnSize) {
    int** result = (int**)malloc(sizeof(int*) * (intervalsSize + 1));
    int i = 0, j = 0;
    int start = newInterval[0], end = newInterval[1];

    while (i < intervalsSize && intervals[i][1] < start) {
        result[j++] = intervals[i++];
    }

    while (i < intervalsSize && intervals[i][0] <= end) {
        start = (start < intervals[i][0]) ? start : intervals[i][0];
        end = (end > intervals[i][1]) ? end : intervals[i][1];
        i++;
    }

    result[j++] = (int*)malloc(sizeof(int) * 2);
    result[j-1][0] = start;
    result[j-1][1] = end;

    while (i < intervalsSize) {
        result[j++] = intervals[i++];
    }

    *returnSize = j;
    return result;
}