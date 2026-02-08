#include <stdlib.h>

typedef struct {
    int* point;
    long long distSq;
} PointDist;

int comparePoints(const void* a, const void* b) {
    PointDist* pd1 = (PointDist*)a;
    PointDist* pd2 = (PointDist*)b;

    if (pd1->distSq < pd2->distSq) {
        return -1;
    } else if (pd1->distSq > pd2->distSq) {
        return 1;
    } else {
        return 0;
    }
}

int** kClosest(int** points, int pointsSize, int* pointsColSize, int k, int* returnSize, int** returnColumnSizes) {
    PointDist* pointDistances = (PointDist*)malloc(pointsSize * sizeof(PointDist));
    if (pointDistances == NULL) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    for (int i = 0; i < pointsSize; i++) {
        pointDistances[i].point = points[i];
        long long x = points[i][0];
        long long y = points[i][1];
        pointDistances[i].distSq = x * x + y * y;
    }

    qsort(pointDistances, pointsSize, sizeof(PointDist), comparePoints);

    int** result = (int**)malloc(k * sizeof(int*));
    if (result == NULL) {
        free(pointDistances);
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    *returnColumnSizes = (int*)malloc(k * sizeof(int));
    if (*returnColumnSizes == NULL) {
        free(pointDistances);
        free(result);
        *returnSize = 0;
        return NULL;
    }

    *returnSize = k;

    for (int i = 0; i < k; i++) {
        result[i] = (int*)malloc(2 * sizeof(int));
        if (result[i] == NULL) {
            // Cleanup previously allocated memory in result and returnColumnSizes
            for (int j = 0; j < i; j++) {
                free(result[j]);
            }
            free(result);
            free(*returnColumnSizes);
            free(pointDistances);
            *returnSize = 0;
            return NULL;
        }
        result[i][0] = pointDistances[i].point[0];
        result[i][1] = pointDistances[i].point[1];
        (*returnColumnSizes)[i] = 2;
    }

    free(pointDistances);

    return result;
}