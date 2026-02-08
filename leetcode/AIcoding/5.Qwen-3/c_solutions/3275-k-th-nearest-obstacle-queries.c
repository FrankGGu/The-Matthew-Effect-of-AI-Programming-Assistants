#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    int index;
    int distance;
} DistIndex;

int compare(const void *a, const void *b) {
    return ((DistIndex *)a)->distance - ((DistIndex *)b)->distance;
}

int* kClosestObstacles(int** obstacles, int obstaclesSize, int* queriesSize, int** queries, int k, int* returnSize) {
    int* result = (int*)malloc(*queriesSize * sizeof(int));
    for (int i = 0; i < *queriesSize; i++) {
        int qx = queries[i][0];
        int qy = queries[i][1];
        DistIndex* dists = (DistIndex*)malloc(obstaclesSize * sizeof(DistIndex));
        for (int j = 0; j < obstaclesSize; j++) {
            int dx = abs(obstacles[j][0] - qx);
            int dy = abs(obstacles[j][1] - qy);
            dists[j].distance = dx + dy;
            dists[j].index = j;
        }
        qsort(dists, obstaclesSize, sizeof(DistIndex), compare);
        result[i] = dists[k-1].index;
        free(dists);
    }
    *returnSize = *queriesSize;
    return result;
}