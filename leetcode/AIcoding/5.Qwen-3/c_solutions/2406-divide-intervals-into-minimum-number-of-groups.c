#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    return x[0] - y[0];
}

int minIntervals(int** intervals, int intervalsSize, int* intervalsColSize) {
    qsort(intervals, intervalsSize, sizeof(int *), compare);
    int *endTimes = (int *)malloc(intervalsSize * sizeof(int));
    int endCount = 0;

    for (int i = 0; i < intervalsSize; i++) {
        int start = intervals[i][0];
        int end = intervals[i][1];
        int j = 0;
        while (j < endCount && endTimes[j] < start) {
            j++;
        }
        if (j < endCount) {
            endTimes[j] = end;
        } else {
            endTimes[endCount++] = end;
        }
    }

    free(endTimes);
    return endCount;
}