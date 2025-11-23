#include <stdlib.h>

int compareInt(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* kthNearestObstacleQueries(int** obstacles, int obstaclesSize, int* obstaclesColSize,
                               int** queries, int queriesSize, int* queriesColSize,
                               int* returnSize) {
    *returnSize = queriesSize;
    int* results = (int*)malloc(sizeof(int) * queriesSize);
    if (results == NULL) {
        return NULL;
    }

    int* distances = (int*)malloc(sizeof(int) * obstaclesSize);
    if (distances == NULL) {
        free(results);
        return NULL;
    }

    for (int i = 0; i < queriesSize; i++) {
        int qx = queries[i][0];
        int qy = queries[i][1];
        int k = queries[i][2];

        for (int j = 0; j < obstaclesSize; j++) {
            int ox = obstacles[j][0];
            int oy = obstacles[j][1];

            long long dx = (long long)qx - ox;
            long long dy = (long long)qy - oy;
            distances[j] = (int)(dx * dx + dy * dy);
        }

        qsort(distances, obstaclesSize, sizeof(int), compareInt);

        results[i] = distances[k - 1];
    }

    free(distances);
    return results;
}