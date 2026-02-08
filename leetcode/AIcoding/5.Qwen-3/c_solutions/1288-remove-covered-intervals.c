#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    if (x[0] == y[0]) {
        return y[1] - x[1];
    }
    return x[0] - y[0];
}

int removeCoveredIntervals(int** intervals, int intervalsSize, int* intervalsColSize) {
    qsort(intervals, intervalsSize, sizeof(int *), compare);
    int count = 1;
    int end = intervals[0][1];
    for (int i = 1; i < intervalsSize; i++) {
        if (intervals[i][1] > end) {
            count++;
            end = intervals[i][1];
        }
    }
    return count;
}