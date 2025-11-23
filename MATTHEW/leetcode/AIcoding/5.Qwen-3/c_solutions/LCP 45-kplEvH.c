#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int cmpfunc(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int assignBikes(int** workers, int workersSize, int* workersColSize, int** bikes, int bikesSize, int* bikesColSize) {
    int* workerToBike = (int*)malloc(workersSize * sizeof(int));
    int* bikeUsed = (int*)calloc(bikesSize, sizeof(int));
    int* dist = (int*)malloc(workersSize * bikesSize * sizeof(int));
    int* idx = (int*)malloc(workersSize * bikesSize * sizeof(int));

    for (int i = 0; i < workersSize; i++) {
        for (int j = 0; j < bikesSize; j++) {
            int d = abs(workers[i][0] - bikes[j][0]) + abs(workers[i][1] - bikes[j][1]);
            dist[i * bikesSize + j] = d;
            idx[i * bikesSize + j] = j;
        }
    }

    for (int i = 0; i < workersSize * bikesSize; i++) {
        for (int j = i + 1; j < workersSize * bikesSize; j++) {
            if (dist[i] > dist[j] || (dist[i] == dist[j] && idx[i] > idx[j])) {
                int temp = dist[i];
                dist[i] = dist[j];
                dist[j] = temp;
                temp = idx[i];
                idx[i] = idx[j];
                idx[j] = temp;
            }
        }
    }

    int count = 0;
    for (int i = 0; i < workersSize * bikesSize; i++) {
        int w = i / bikesSize;
        int b = idx[i];
        if (!bikeUsed[b] && workerToBike[w] == 0) {
            workerToBike[w] = b + 1;
            bikeUsed[b] = 1;
            count++;
            if (count == workersSize) break;
        }
    }

    free(dist);
    free(idx);
    free(bikeUsed);

    return count;
}