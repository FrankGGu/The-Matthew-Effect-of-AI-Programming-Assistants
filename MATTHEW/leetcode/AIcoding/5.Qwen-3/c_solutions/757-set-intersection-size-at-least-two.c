#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    if (x[0] != y[0]) return x[0] - y[0];
    return y[1] - x[1];
}

int intersectionSizeAtLeastTwo(int** intervals, int intervalsSize, int* intervalsColSize) {
    qsort(intervals, intervalsSize, sizeof(int *), compare);

    int res = 0;
    int last = -1, secondLast = -1;

    for (int i = 0; i < intervalsSize; i++) {
        int start = intervals[i][0];
        int end = intervals[i][1];

        if (start > secondLast) {
            res += 2;
            secondLast = end;
            last = end;
        } else if (start > last) {
            res += 1;
            secondLast = last;
            last = end;
        }
    }

    return res;
}