#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int* assignBikes(int** workers, int workersSize, int* workersColSize, int** bikes, int bikesSize, int* bikesColSize, int* returnSize) {
    int* result = (int*)malloc(workersSize * sizeof(int));
    int* usedBike = (int*)calloc(bikesSize, sizeof(int));

    for (int i = 0; i < workersSize; i++) {
        result[i] = -1;
    }

    for (int i = 0; i < workersSize; i++) {
        int minDist = INT_MAX;
        int selectedBike = -1;
        for (int j = 0; j < bikesSize; j++) {
            if (usedBike[j] == 0) {
                int dist = abs(workers[i][0] - bikes[j][0]) + abs(workers[i][1] - bikes[j][1]);
                if (dist < minDist) {
                    minDist = dist;
                    selectedBike = j;
                }
            }
        }
        if (selectedBike != -1) {
            result[i] = selectedBike;
            usedBike[selectedBike] = 1;
        }
    }

    *returnSize = workersSize;
    return result;
}