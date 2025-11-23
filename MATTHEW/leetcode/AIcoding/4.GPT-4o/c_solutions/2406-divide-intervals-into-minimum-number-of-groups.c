#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return ((int*)a)[0] - ((int*)b)[0];
}

int minGroups(int** intervals, int intervalsSize, int* intervalsColSize) {
    int n = intervalsSize;
    int end[n];

    for (int i = 0; i < n; i++) {
        end[i] = intervals[i][1];
    }

    qsort(intervals, n, sizeof(int*), cmp);

    int groups = 0;
    int currEnd = 0;

    for (int i = 0; i < n; i++) {
        if (currEnd < intervals[i][0]) {
            groups++;
            currEnd = end[i];
        } else {
            currEnd = currEnd > end[i] ? currEnd : end[i];
        }
    }

    return groups;
}