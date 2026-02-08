#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    int *x = *(int **)a;
    int *y = *(int **)b;
    if (x[1] != y[1]) {
        return x[1] - y[1];
    }
    return y[0] - x[0];
}

int intersectionSizeTwo(int** intervals, int intervalsSize, int* intervalsColSize){
    qsort(intervals, intervalsSize, sizeof(intervals[0]), cmp);
    int ans = 0;
    int a = -1, b = -1;
    for (int i = 0; i < intervalsSize; i++) {
        int start = intervals[i][0];
        int end = intervals[i][1];
        if (a >= start && b >= start) {
            continue;
        } else if (a >= start && b < start) {
            ans++;
            a = b;
            b = end;
        } else {
            ans += 2;
            a = end - 1;
            b = end;
        }
    }
    return ans;
}