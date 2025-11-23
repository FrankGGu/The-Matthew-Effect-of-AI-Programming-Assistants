#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int x;
    int y;
} Point;

int cmp(const void *a, const void *b) {
    double angleA = atan2(((Point *)a)->y, ((Point *)a)->x);
    double angleB = atan2(((Point *)b)->y, ((Point *)b)->x);
    return (angleA > angleB) - (angleA < angleB);
}

int maxVisiblePoints(Point* points, int pointsSize, Point* location, double angle) {
    Point *angles = malloc(pointsSize * sizeof(Point));
    for (int i = 0; i < pointsSize; i++) {
        angles[i].x = points[i].x - location->x;
        angles[i].y = points[i].y - location->y;
    }

    qsort(angles, pointsSize, sizeof(Point), cmp);

    int *visible = malloc((pointsSize * 2) * sizeof(int));
    for (int i = 0; i < pointsSize; i++) {
        visible[i] = atan2(angles[i].y, angles[i].x) * 180.0 / M_PI; 
    }

    for (int i = 0; i < pointsSize; i++) {
        visible[i + pointsSize] = visible[i] + 360; 
    }

    int maxVisible = 0;
    for (int i = 0, j = 0; i < pointsSize; i++) {
        while (j < pointsSize * 2 && visible[j] <= visible[i] + angle) {
            j++;
        }
        maxVisible = fmax(maxVisible, j - i);
    }

    free(angles);
    free(visible);
    return maxVisible;
}