#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int strongestBlessing(int** ranges, int rangesSize, int* rangesColSize) {
    int n = rangesSize;
    qsort(ranges, n, sizeof(ranges[0]), [](const void* a, const void* b) {
        return (*(int**)a)[0] - (*(int**)b)[0];
    });

    int ans = 0;
    int currentEnd = -1;
    int currentCount = 0;

    for (int i = 0; i < n; i++) {
        if (ranges[i][0] <= currentEnd) {
            currentEnd = max(currentEnd, ranges[i][1]);
            currentCount++;
        } else {
            ans = max(ans, currentCount);
            currentEnd = ranges[i][1];
            currentCount = 1;
        }
    }

    ans = max(ans, currentCount);
    return ans;
}