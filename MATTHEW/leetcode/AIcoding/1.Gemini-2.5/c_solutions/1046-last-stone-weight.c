#include <stdlib.h> // Required for qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int lastStoneWeight(int* stones, int stonesSize) {
    if (stonesSize == 0) {
        return 0;
    }
    if (stonesSize == 1) {
        return stones[0];
    }

    while (stonesSize > 1) {
        qsort(stones, stonesSize, sizeof(int), compare);

        int y = stones[stonesSize - 1];
        int x = stones[stonesSize - 2];

        stonesSize -= 2;

        if (y != x) {
            int newStoneWeight = y - x;
            stones[stonesSize] = newStoneWeight;
            stonesSize++;
        }
    }

    return (stonesSize == 1) ? stones[0] : 0;
}