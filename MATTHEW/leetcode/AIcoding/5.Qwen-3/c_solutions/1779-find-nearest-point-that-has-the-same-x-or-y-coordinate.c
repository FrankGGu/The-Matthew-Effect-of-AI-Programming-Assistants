#include <stdio.h>
#include <stdlib.h>

int* nearestValidPoint(int* points, int pointsSize, int* point, int pointSize, int* returnSize) {
    int x = point[0];
    int y = point[1];
    int minDist = -1;
    int index = -1;

    for (int i = 0; i < pointsSize; i++) {
        int px = points[i][0];
        int py = points[i][1];
        if (px == x || py == y) {
            int dist = abs(px - x) + abs(py - y);
            if (minDist == -1 || dist < minDist) {
                minDist = dist;
                index = i;
            }
        }
    }

    *returnSize = 1;
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = index;
    result[1] = minDist;
    return result;
}