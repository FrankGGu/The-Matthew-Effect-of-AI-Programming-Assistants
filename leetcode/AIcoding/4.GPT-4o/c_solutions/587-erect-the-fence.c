#include <stdlib.h>

typedef struct {
    int x;
    int y;
} Point;

int compare(const void *a, const void *b) {
    Point *p1 = (Point *)a;
    Point *p2 = (Point *)b;
    if (p1->x != p2->x) return p1->x - p2->x;
    return p1->y - p2->y;
}

int cross(Point p1, Point p2, Point p3) {
    return (p2.x - p1.x) * (p3.y - p1.y) - (p2.y - p1.y) * (p3.x - p1.x);
}

Point* outerTrees(Point* points, int pointsSize, int* returnSize) {
    if (pointsSize <= 1) {
        *returnSize = pointsSize;
        return points;
    }

    qsort(points, pointsSize, sizeof(Point), compare);

    Point* hull = (Point*)malloc(2 * pointsSize * sizeof(Point));
    int k = 0;

    for (int i = 0; i < pointsSize; i++) {
        while (k >= 2 && cross(hull[k - 2], hull[k - 1], points[i]) < 0) k--;
        hull[k++] = points[i];
    }

    int t = k + 1;
    for (int i = pointsSize - 2; i >= 0; i--) {
        while (k >= t && cross(hull[k - 2], hull[k - 1], points[i]) < 0) k--;
        hull[k++] = points[i];
    }

    *returnSize = k - 1;
    Point* result = (Point*)malloc((*returnSize) * sizeof(Point));
    for (int i = 0; i < *returnSize; i++) {
        result[i] = hull[i];
    }

    free(hull);
    return result;
}