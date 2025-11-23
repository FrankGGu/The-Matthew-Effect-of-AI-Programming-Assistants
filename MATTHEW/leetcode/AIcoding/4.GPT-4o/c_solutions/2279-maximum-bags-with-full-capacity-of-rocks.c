#include <stdlib.h>

int maximumBags(int* capacity, int capacitySize, int* rocks, int rocksSize, int additionalRocks, int* returnSize) {
    int* remaining = (int*)malloc(capacitySize * sizeof(int));
    for (int i = 0; i < capacitySize; i++) {
        remaining[i] = capacity[i] - rocks[i];
    }

    qsort(remaining, capacitySize, sizeof(int), cmp);

    int count = 0;
    for (int i = 0; i < capacitySize; i++) {
        if (remaining[i] == 0) {
            count++;
        } else if (additionalRocks >= remaining[i]) {
            additionalRocks -= remaining[i];
            count++;
        } else {
            break;
        }
    }

    free(remaining);
    *returnSize = count;
    return count;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}