#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxDistance(int** points, int pointsSize, int* pointsColSize) {
    int x[pointsSize], y[pointsSize];
    for (int i = 0; i < pointsSize; i++) {
        x[i] = points[i][0];
        y[i] = points[i][1];
    }
    qsort(x, pointsSize, sizeof(int), compare);
    qsort(y, pointsSize, sizeof(int), compare);
    int max_x = x[pointsSize - 1] - x[0];
    int max_y = y[pointsSize - 1] - y[0];
    return max_x + max_y;
}