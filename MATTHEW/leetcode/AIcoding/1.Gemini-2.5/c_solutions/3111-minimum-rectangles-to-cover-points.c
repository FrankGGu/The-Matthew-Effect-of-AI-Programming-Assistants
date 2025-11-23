#include <stdlib.h>

int comparePoints(const void *a, const void *b) {
    const int *point1 = *(const int **)a;
    const int *point2 = *(const int **)b;
    return point1[0] - point2[0];
}

int minRectanglesToCoverPoints(int** points, int pointsSize, int* pointsColSize, int w) {
    if (pointsSize == 0) {
        return 0;
    }

    qsort(points, pointsSize, sizeof(int*), comparePoints);

    int rectangles = 0;
    int i = 0;
    while (i < pointsSize) {
        rectangles++;
        int current_x = points[i][0];
        int cover_limit = current_x + w;

        while (i < pointsSize && points[i][0] <= cover_limit) {
            i++;
        }
    }

    return rectangles;
}