#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* countRectangles(int** rectangles, int rectanglesSize, int* rectanglesColSize, int** points, int pointsSize, int* pointsColSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * pointsSize);
    *returnSize = pointsSize;

    for (int i = 0; i < pointsSize; i++) {
        int count = 0;
        for (int j = 0; j < rectanglesSize; j++) {
            if (rectangles[j][0] >= points[i][0] && rectangles[j][1] >= points[i][1]) {
                count++;
            }
        }
        result[i] = count;
    }

    return result;
}