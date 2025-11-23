#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumBags(int* capacity, int capacitySize, int* rocks, int rocksSize, int additionalRocks) {
    int* diff = (int*)malloc(sizeof(int) * capacitySize);
    for (int i = 0; i < capacitySize; i++) {
        diff[i] = capacity[i] - rocks[i];
    }

    int count = 0;
    qsort(diff, capacitySize, sizeof(int), [](const void* a, const void* b) {
        return (*(int*)a - *(int*)b);
    });

    for (int i = 0; i < capacitySize; i++) {
        if (diff[i] <= additionalRocks) {
            additionalRocks -= diff[i];
            count++;
        } else {
            break;
        }
    }

    free(diff);
    return count;
}