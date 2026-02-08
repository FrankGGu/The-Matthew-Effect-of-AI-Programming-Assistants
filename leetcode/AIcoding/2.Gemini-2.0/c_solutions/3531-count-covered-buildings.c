#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* countCoveredBuildings(int** ranges, int rangesSize, int* rangesColSize, int* resultSize) {
    int maxRight = 0;
    for (int i = 0; i < rangesSize; i++) {
        if (ranges[i][1] > maxRight) {
            maxRight = ranges[i][1];
        }
    }

    int* diff = (int*)calloc(maxRight + 2, sizeof(int));

    for (int i = 0; i < rangesSize; i++) {
        diff[ranges[i][0]]++;
        diff[ranges[i][1] + 1]--;
    }

    int* result = (int*)malloc(sizeof(int) * rangesSize);
    int count = 0;
    int covered = 0;
    for (int i = 0; i <= maxRight; i++) {
        covered += diff[i];
        if (covered > 0) {
            count++;
        }
    }

    result[0] = count;
    *resultSize = 1;

    free(diff);

    return result;
}