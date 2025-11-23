#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxWidthOfVerticalArea(int** points, int pointsSize, int* pointsColSize) {
    int *xCoordinates = (int*)malloc(pointsSize * sizeof(int));
    for (int i = 0; i < pointsSize; i++) {
        xCoordinates[i] = points[i][0];
    }
    qsort(xCoordinates, pointsSize, sizeof(int), compare);
    int maxWidth = 0;
    for (int i = 1; i < pointsSize; i++) {
        int width = xCoordinates[i] - xCoordinates[i-1];
        if (width > maxWidth) {
            maxWidth = width;
        }
    }
    free(xCoordinates);
    return maxWidth;
}