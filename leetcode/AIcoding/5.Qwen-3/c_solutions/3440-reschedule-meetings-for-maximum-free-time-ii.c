#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    return x[1] - y[1];
}

int* maxFreeTime(int** intervals, int intervalsSize, int* intervalsColSize, int* returnSize) {
    qsort(intervals, intervalsSize, sizeof(int*), compare);

    int* result = (int*)malloc(2 * sizeof(int));
    int freeStart = 0;
    int maxFree = 0;

    for (int i = 0; i < intervalsSize; i++) {
        if (freeStart < intervals[i][0]) {
            int free = intervals[i][0] - freeStart;
            if (free > maxFree) {
                maxFree = free;
                result[0] = freeStart;
                result[1] = intervals[i][0];
            }
        }
        freeStart = intervals[i][1];
    }

    *returnSize = 2;
    return result;
}