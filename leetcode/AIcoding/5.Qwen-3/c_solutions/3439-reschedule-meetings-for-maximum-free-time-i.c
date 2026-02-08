#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    return x[0] - y[0];
}

int* maxFreeTime(int** intervals, int intervalsSize, int* intervalsColSize, int* returnSize) {
    qsort(intervals, intervalsSize, sizeof(int *), compare);

    int* result = (int *)malloc(2 * sizeof(int));
    int freeStart = 0;
    int maxFree = 0;

    for (int i = 1; i < intervalsSize; i++) {
        int start = intervals[i][0];
        int end = intervals[i][1];
        int prevEnd = intervals[i - 1][1];

        if (start > prevEnd) {
            int free = start - prevEnd;
            if (free > maxFree) {
                maxFree = free;
                freeStart = prevEnd;
            }
        }
    }

    result[0] = freeStart;
    result[1] = freeStart + maxFree;
    *returnSize = 2;
    return result;
}