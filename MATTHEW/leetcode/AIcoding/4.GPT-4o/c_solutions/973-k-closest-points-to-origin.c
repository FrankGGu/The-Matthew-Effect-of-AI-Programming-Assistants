#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    Point point;
    double distance;
} PointDistance;

int compare(const void *a, const void *b) {
    PointDistance *pd1 = (PointDistance *)a;
    PointDistance *pd2 = (PointDistance *)b;
    if (pd1->distance < pd2->distance) return -1;
    if (pd1->distance > pd2->distance) return 1;
    return 0;
}

Point* kClosest(int** points, int pointsSize, int pointsColSize, int k, int* returnSize) {
    PointDistance *pdArray = (PointDistance *)malloc(pointsSize * sizeof(PointDistance));
    for (int i = 0; i < pointsSize; i++) {
        pdArray[i].point.x = points[i][0];
        pdArray[i].point.y = points[i][1];
        pdArray[i].distance = (points[i][0] * points[i][0]) + (points[i][1] * points[i][1]);
    }

    qsort(pdArray, pointsSize, sizeof(PointDistance), compare);

    Point *result = (Point *)malloc(k * sizeof(Point));
    for (int i = 0; i < k; i++) {
        result[i] = pdArray[i].point;
    }

    free(pdArray);
    *returnSize = k;
    return result;
}