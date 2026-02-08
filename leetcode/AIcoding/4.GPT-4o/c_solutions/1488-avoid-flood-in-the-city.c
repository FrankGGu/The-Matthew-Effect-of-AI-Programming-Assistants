#include <stdio.h>
#include <stdlib.h>

#define MAX_DAYS 20001

int avoidFlood(int* rains, int rainsSize, int* returnSize) {
    int* lakeDays = (int*)calloc(MAX_DAYS, sizeof(int));
    int* result = (int*)malloc(rainsSize * sizeof(int));
    int* stack = (int*)malloc(rainsSize * sizeof(int));
    int stackSize = 0;
    int i;

    for (i = 0; i < rainsSize; i++) {
        if (rains[i] > 0) {
            if (lakeDays[rains[i]] > 0) {
                free(lakeDays);
                free(result);
                free(stack);
                *returnSize = 0;
                return NULL;
            }
            lakeDays[rains[i]] = i + 1;
            result[i] = -1;
        } else {
            result[i] = 1;
            if (stackSize > 0) {
                int lake = stack[--stackSize];
                result[lake] = 0;
            }
        }
        if (i < rainsSize - 1 && rains[i + 1] > 0) {
            stack[stackSize++] = i;
        }
    }

    *returnSize = rainsSize;
    free(lakeDays);
    free(stack);
    return result;
}