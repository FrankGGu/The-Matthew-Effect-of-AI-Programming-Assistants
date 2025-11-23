#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    return x[0] - y[0];
}

int countGroups(int** ranges, int rangesSize, int* rangesColSize) {
    qsort(ranges, rangesSize, sizeof(int*), compare);
    int count = 1;
    int end = ranges[0][1];
    for (int i = 1; i < rangesSize; i++) {
        if (ranges[i][0] > end) {
            count++;
            end = ranges[i][1];
        }
    }
    return count;
}