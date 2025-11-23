#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return ((int*)a)[1] - ((int*)b)[1];
}

int maxNonOverlappingIntervals(int intervals[][3], int intervalsSize, int* intervalsColSize){
    if (intervalsSize == 0) return 0;

    qsort(intervals, intervalsSize, sizeof(intervals[0]), compare);

    int count = 1;
    int end = intervals[0][1];

    for (int i = 1; i < intervalsSize; i++) {
        if (intervals[i][0] >= end) {
            count++;
            end = intervals[i][1];
        }
    }

    return count;
}