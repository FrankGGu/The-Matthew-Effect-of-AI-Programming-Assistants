#include <stdlib.h>

int compareIntegers(const void *a, const void *b) {
    return (*(int *)a - *(int *)b);
}

int maximumBags(int* capacity, int capacitySize, int* rocks, int rocksSize, int additionalRocks) {
    int* remainingCapacity = (int*)malloc(capacitySize * sizeof(int));
    if (remainingCapacity == NULL) {
        return 0; // Handle allocation failure
    }

    for (int i = 0; i < capacitySize; i++) {
        remainingCapacity[i] = capacity[i] - rocks[i];
    }

    qsort(remainingCapacity, capacitySize, sizeof(int), compareIntegers);

    int fullBags = 0;
    for (int i = 0; i < capacitySize; i++) {
        if (remainingCapacity[i] <= 0) {
            fullBags++;
        } else if (additionalRocks >= remainingCapacity[i]) {
            additionalRocks -= remainingCapacity[i];
            fullBags++;
        } else {
            break;
        }
    }

    free(remainingCapacity);
    return fullBags;
}