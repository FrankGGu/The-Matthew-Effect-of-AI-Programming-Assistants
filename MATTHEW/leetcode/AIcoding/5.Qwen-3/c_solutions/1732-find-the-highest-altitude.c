#include <stdio.h>
#include <stdlib.h>

int* getHighestAltitude(int* gain, int gainSize, int* returnSize) {
    int maxAltitude = 0;
    int currentAltitude = 0;
    for (int i = 0; i < gainSize; i++) {
        currentAltitude += gain[i];
        if (currentAltitude > maxAltitude) {
            maxAltitude = currentAltitude;
        }
    }
    *returnSize = 1;
    int* result = (int*)malloc(sizeof(int));
    result[0] = maxAltitude;
    return result;
}