#include <stdlib.h>

static int compareIntervals(const void* a, const void* b) {
    const int* intervalA = *(const int**)a;
    const int* intervalB = *(const int**)b;

    if (intervalA[0] != intervalB[0]) {
        return intervalA[0] - intervalB[0];
    } else {
        return intervalB[1] - intervalA[1];
    }
}

int removeCoveredIntervals(int** intervals, int intervalsSize, int* intervalsColSize) {
    if (intervalsSize <= 1) {
        return intervalsSize;
    }

    qsort(intervals, intervalsSize, sizeof(int*), compareIntervals);

    int count = 0;
    int maxEnd = -1;

    for (int i = 0; i < intervalsSize; ++i) {
        int currentEnd = intervals[i][1];

        if (currentEnd > maxEnd) {
            count++;
            maxEnd = currentEnd;
        }
    }

    return count;
}