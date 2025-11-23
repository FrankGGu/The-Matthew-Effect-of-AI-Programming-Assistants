#include <stdio.h>
#include <stdlib.h>

struct Point {
    int x;
    int y;
};

int* countPoints(struct Point* points, int pointsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        int cx = queries[i][0], cy = queries[i][1], r = queries[i][2];
        int count = 0;
        for (int j = 0; j < pointsSize; j++) {
            if ((points[j].x - cx) * (points[j].x - cx) + (points[j].y - cy) * (points[j].y - cy) <= r * r) {
                count++;
            }
        }
        result[i] = count;
    }
    *returnSize = queriesSize;
    return result;
}