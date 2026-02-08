#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return ((int*)a)[1] - ((int*)b)[1];
}

int findMinArrowShots(int** points, int pointsSize, int* pointsColSize){
    if (pointsSize == 0) return 0;

    qsort(points, pointsSize, sizeof(points[0]), compare);

    int arrows = 1;
    int end = points[0][1];

    for (int i = 1; i < pointsSize; i++) {
        if (points[i][0] > end) {
            arrows++;
            end = points[i][1];
        }
    }

    return arrows;
}