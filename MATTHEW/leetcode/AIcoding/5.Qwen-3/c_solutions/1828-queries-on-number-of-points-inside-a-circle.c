#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int x;
    int y;
    int r;
} Query;

typedef struct {
    int x;
    int y;
} Point;

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int* countPoints(int** points, int pointsSize, int* pointsColSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        int cx = queries[i][0];
        int cy = queries[i][1];
        int cr = queries[i][2];
        int count = 0;
        for (int j = 0; j < pointsSize; j++) {
            int dx = points[j][0] - cx;
            int dy = points[j][1] - cy;
            if (dx * dx + dy * dy <= cr * cr) {
                count++;
            }
        }
        result[i] = count;
    }
    *returnSize = queriesSize;
    return result;
}