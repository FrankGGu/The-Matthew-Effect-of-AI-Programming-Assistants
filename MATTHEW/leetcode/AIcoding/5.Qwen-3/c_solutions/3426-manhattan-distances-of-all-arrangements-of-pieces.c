#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int x;
    int y;
} Point;

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int** assignBikes(int** workers, int workersSize, int* workersColSize, int** bikes, int bikesSize, int* bikesColSize, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(workersSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(workersSize * sizeof(int));
    for (int i = 0; i < workersSize; i++) {
        result[i] = (int*)malloc(2 * sizeof(int));
        (*returnColumnSizes)[i] = 2;
    }

    int* dists = (int*)malloc(workersSize * bikesSize * sizeof(int));
    int* indices = (int*)malloc(workersSize * bikesSize * sizeof(int));

    int index = 0;
    for (int w = 0; w < workersSize; w++) {
        for (int b = 0; b < bikesSize; b++) {
            int dx = abs(workers[w][0] - bikes[b][0]);
            int dy = abs(workers[w][1] - bikes[b][1]);
            dists[index] = dx + dy;
            indices[index] = w * bikesSize + b;
            index++;
        }
    }

    qsort(indices, workersSize * bikesSize, sizeof(int), compare);

    int* usedBikes = (int*)calloc(bikesSize, sizeof(int));
    int* assigned = (int*)calloc(workersSize, sizeof(int));

    int count = 0;
    for (int i = 0; i < workersSize * bikesSize && count < workersSize; i++) {
        int idx = indices[i];
        int w = idx / bikesSize;
        int b = idx % bikesSize;

        if (!usedBikes[b] && !assigned[w]) {
            result[w][0] = w;
            result[w][1] = b;
            usedBikes[b] = 1;
            assigned[w] = 1;
            count++;
        }
    }

    *returnSize = workersSize;
    return result;
}