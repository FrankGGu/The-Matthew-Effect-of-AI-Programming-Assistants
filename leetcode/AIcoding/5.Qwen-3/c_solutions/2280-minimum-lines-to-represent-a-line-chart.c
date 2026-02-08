#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *x = (int *)a;
    int *y = (int *)b;
    return x[0] - y[0];
}

int findMinimumNumberOfLines(int** coordinates, int coordinatesSize, int* coordinatesColSize) {
    if (coordinatesSize <= 1) return 0;

    qsort(coordinates, coordinatesSize, sizeof(int*), compare);

    int lines = 1;
    for (int i = 2; i < coordinatesSize; i++) {
        int x1 = coordinates[i-2][0], y1 = coordinates[i-2][1];
        int x2 = coordinates[i-1][0], y2 = coordinates[i-1][1];
        int x3 = coordinates[i][0], y3 = coordinates[i][1];

        long long dy1 = (long long)(y2 - y1) * (x3 - x2);
        long long dy2 = (long long)(y3 - y2) * (x2 - x1);

        if (dy1 != dy2) {
            lines++;
        }
    }

    return lines;
}