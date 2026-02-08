#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int intersectionSizeTwo(int** intervals, int intervalsSize, int* intervalsColSize) {
    qsort(intervals, intervalsSize, sizeof(int*), cmp);

    int count = 0;
    int max1 = -1, max2 = -1;

    for (int i = intervalsSize - 1; i >= 0; i--) {
        if (max2 < intervals[i][0]) {
            count += 2;
            max1 = intervals[i][1];
            max2 = max1 - 1;
        } else if (max1 < intervals[i][0]) {
            count += 1;
            max1 = max2;
            max2 = intervals[i][1];
        } else {
            max1 = max1 > intervals[i][1] ? max1 : intervals[i][1];
        }
    }

    return count;
}