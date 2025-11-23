#include <stdio.h>
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

int minRectangles(Point* points, int pointsSize) {
    if (pointsSize == 0) return 0;

    qsort(points, pointsSize, sizeof(Point), compare);

    int count = 0;
    int minY = points[0].y, maxY = points[0].y;
    int prevX = points[0].x;

    for (int i = 1; i < pointsSize; i++) {
        if (points[i].x != prevX) {
            count++;
            prevX = points[i].x;
            minY = points[i].y;
            maxY = points[i].y;
        } else {
            if (points[i].y < minY) {
                minY = points[i].y;
            }
            if (points[i].y > maxY) {
                maxY = points[i].y;
            }
        }
    }

    return count + 1;
}