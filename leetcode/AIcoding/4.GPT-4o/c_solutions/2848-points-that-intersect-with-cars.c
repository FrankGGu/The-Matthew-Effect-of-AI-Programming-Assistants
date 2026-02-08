#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x;
    int y;
} Point;

int cmp(const void *a, const void *b) {
    return ((Point *)a)->x - ((Point *)b)->x;
}

int pointIntersectCars(Point* points, int pointsSize, int* cars, int carsSize) {
    qsort(points, pointsSize, sizeof(Point), cmp);

    int count = 0;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = 0; j < carsSize; j++) {
            if (points[i].x >= cars[j] && points[i].x <= cars[j] + 1) {
                count++;
                break;
            }
        }
    }
    return count;
}