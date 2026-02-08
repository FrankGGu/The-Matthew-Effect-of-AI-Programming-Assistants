#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int *p1 = (int *)a;
    int *p2 = (int *)b;
    if (p1[0] != p2[0]) return p1[0] - p2[0];
    return p1[1] - p2[1];
}

bool isBoomerang(int** points, int pointsSize, int* pointsColSize) {
    qsort(points, pointsSize, sizeof(int*), compare);
    int x1 = points[0][0], y1 = points[0][1];
    int x2 = points[1][0], y2 = points[1][1];
    int x3 = points[2][0], y3 = points[2][1];

    return (y2 - y1) * (x3 - x1) != (y3 - y1) * (x2 - x1);
}