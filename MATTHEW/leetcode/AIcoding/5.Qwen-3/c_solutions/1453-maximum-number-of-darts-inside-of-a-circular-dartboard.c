#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int x;
    int y;
} Point;

double distance(Point a, Point b) {
    return sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
}

int compare(const void* a, const void* b) {
    return (*(double*)a - *(double*)b);
}

int maxPointsInsideCircle(int** darts, int dartsSize, int* dartsColSize, int radius) {
    if (dartsSize <= 1) return dartsSize;

    int maxCount = 0;
    for (int i = 0; i < dartsSize; i++) {
        Point p1 = {darts[i][0], darts[i][1]};
        double* dists = (double*)malloc(dartsSize * sizeof(double));
        int count = 0;
        for (int j = 0; j < dartsSize; j++) {
            Point p2 = {darts[j][0], darts[j][1]};
            dists[count++] = distance(p1, p2);
        }
        qsort(dists, count, sizeof(double), compare);
        int current = 0;
        for (int k = 0; k < count; k++) {
            if (dists[k] <= radius) current++;
        }
        maxCount = (current > maxCount) ? current : maxCount;
        free(dists);
    }
    return maxCount;
}