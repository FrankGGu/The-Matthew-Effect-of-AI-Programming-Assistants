#include <stdio.h>
#include <stdlib.h>

int* temperatureTrend(int* temperatureA, int temperatureASize, int* temperatureB, int temperatureBSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * (temperatureASize < temperatureBSize ? temperatureASize : temperatureBSize));
    *returnSize = 0;
    for (int i = 0; i < (temperatureASize < temperatureBSize ? temperatureASize : temperatureBSize); i++) {
        if (temperatureA[i] > temperatureB[i]) {
            result[*returnSize] = 1;
        } else if (temperatureA[i] < temperatureB[i]) {
            result[*returnSize] = -1;
        } else {
            result[*returnSize] = 0;
        }
        (*returnSize)++;
    }
    return result;
}