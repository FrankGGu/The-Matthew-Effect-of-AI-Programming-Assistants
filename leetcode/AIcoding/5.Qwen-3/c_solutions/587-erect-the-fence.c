#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int x;
    int y;
} Point;

int crossProduct(Point a, Point b, Point c) {
    return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
}

int comparePoints(const void *a, const void *b) {
    Point *p1 = (Point *)a;
    Point *p2 = (Point *)b;
    if (p1->x != p2->x) return p1->x - p2->x;
    return p1->y - p2->y;
}

Point* outerTrees(Point* points, int pointsSize, int* returnSize) {
    if (pointsSize <= 1) {
        *returnSize = pointsSize;
        return points;
    }

    qsort(points, pointsSize, sizeof(Point), comparePoints);

    Point* lower = (Point*)malloc(sizeof(Point) * pointsSize);
    int lowerSize = 0;

    for (int i = 0; i < pointsSize; i++) {
        while (lowerSize >= 2 && crossProduct(lower[lowerSize-2], lower[lowerSize-1], points[i]) < 0) {
            lowerSize--;
        }
        lower[lowerSize++] = points[i];
    }

    Point* upper = (Point*)malloc(sizeof(Point) * pointsSize);
    int upperSize = 0;

    for (int i = pointsSize - 1; i >= 0; i--) {
        while (upperSize >= 2 && crossProduct(upper[upperSize-2], upper[upperSize-1], points[i]) < 0) {
            upperSize--;
        }
        upper[upperSize++] = points[i];
    }

    *returnSize = lowerSize + upperSize - 2;
    Point* result = (Point*)malloc(sizeof(Point) * (*returnSize));
    for (int i = 0; i < lowerSize; i++) {
        result[i] = lower[i];
    }
    for (int i = 1; i < upperSize - 1; i++) {
        result[lowerSize + i - 1] = upper[i];
    }

    free(lower);
    free(upper);
    return result;
}