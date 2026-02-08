#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* avoidFlood(int* rains, int rainsSize, int* returnSize) {
    int* result = (int*)malloc(rainsSize * sizeof(int));
    int* rainDays = (int*)malloc((rainsSize + 1) * sizeof(int));
    int* lakeIndices = (int*)malloc(rainsSize * sizeof(int));
    int lakeCount = 0;
    int lakeIndex = 0;
    int* available = (int*)malloc(rainsSize * sizeof(int));
    int availableSize = 0;

    for (int i = 0; i < rainsSize; i++) {
        if (rains[i] == 0) {
            available[availableSize++] = i;
        } else {
            if (rainDays[rains[i]] != 0) {
                int prev = rainDays[rains[i]];
                int found = 0;
                for (int j = 0; j < availableSize; j++) {
                    if (available[j] > prev) {
                        result[available[j]] = rains[prev];
                        available[j] = -1;
                        found = 1;
                        break;
                    }
                }
                if (!found) {
                    *returnSize = 0;
                    free(result);
                    free(rainDays);
                    free(lakeIndices);
                    free(available);
                    return NULL;
                }
            }
            rainDays[rains[i]] = i;
        }
    }

    for (int i = 0; i < availableSize; i++) {
        if (available[i] != -1) {
            result[available[i]] = 1;
        }
    }

    *returnSize = rainsSize;
    return result;
}