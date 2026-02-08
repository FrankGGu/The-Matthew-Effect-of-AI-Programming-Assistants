#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Point {
    int x;
    int y;
};

int compare(const void *a, const void *b) {
    struct Point *p1 = (struct Point *)a;
    struct Point *p2 = (struct Point *)b;
    double dist1 = sqrt(p1->x * p1->x + p1->y * p1->y);
    double dist2 = sqrt(p2->x * p2->x + p2->y * p2->y);
    if (dist1 < dist2) return -1;
    if (dist1 > dist2) return 1;
    return 0;
}

int** kClosest(int** points, int pointsSize, int* pointsColSize, int k, int* returnSize, int** returnColumnSizes) {
    struct Point* pointArray = (struct Point*)malloc(pointsSize * sizeof(struct Point));
    for (int i = 0; i < pointsSize; i++) {
        pointArray[i].x = points[i][0];
        pointArray[i].y = points[i][1];
    }

    qsort(pointArray, pointsSize, sizeof(struct Point), compare);

    int** result = (int**)malloc(k * sizeof(int*));
    *returnColumnSizes = (int*)malloc(k * sizeof(int));

    for (int i = 0; i < k; i++) {
        result[i] = (int*)malloc(2 * sizeof(int));
        result[i][0] = pointArray[i].x;
        result[i][1] = pointArray[i].y;
        (*returnColumnSizes)[i] = 2;
    }

    *returnSize = k;
    free(pointArray);
    return result;
}