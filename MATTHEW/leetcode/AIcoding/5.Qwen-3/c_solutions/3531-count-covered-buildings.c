#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x;
    int y;
} Point;

int compare(const void *a, const void *b) {
    Point *p1 = (Point *)a;
    Point *p2 = (Point *)b;
    return p1->x - p2->x;
}

int countCoveredBuildings(int** points, int pointsSize, int* pointsColSize) {
    Point *sorted = (Point *)malloc(pointsSize * sizeof(Point));
    for (int i = 0; i < pointsSize; i++) {
        sorted[i].x = points[i][0];
        sorted[i].y = points[i][1];
    }
    qsort(sorted, pointsSize, sizeof(Point), compare);

    int count = 0;
    int prevY = -1;
    for (int i = 0; i < pointsSize; i++) {
        if (sorted[i].y > prevY) {
            count++;
            prevY = sorted[i].y;
        }
    }
    free(sorted);
    return count;
}