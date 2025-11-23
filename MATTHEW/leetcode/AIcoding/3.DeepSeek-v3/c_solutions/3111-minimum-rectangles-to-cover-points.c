#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int minRectanglesToCoverPoints(int** points, int pointsSize, int* pointsColSize, int w) {
    int* x_coords = (int*)malloc(pointsSize * sizeof(int));
    for (int i = 0; i < pointsSize; i++) {
        x_coords[i] = points[i][0];
    }

    qsort(x_coords, pointsSize, sizeof(int), cmp);

    int count = 0;
    int i = 0;
    while (i < pointsSize) {
        int start = x_coords[i];
        while (i < pointsSize && x_coords[i] <= start + w) {
            i++;
        }
        count++;
    }

    free(x_coords);
    return count;
}