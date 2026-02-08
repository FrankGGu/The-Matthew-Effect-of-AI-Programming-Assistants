#include <stdlib.h> // For malloc, qsort, free

int compareInts(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int makeKSubarraySumsEqual(int* arr, int arrSize, int k) {
    int totalChanges = 0;

    int* cycleElements = (int*)malloc(arrSize * sizeof(int));

    for (int i = 0; i < k; ++i) {
        int currentIdx = i;
        int cycleCount = 0;

        do {
            cycleElements[cycleCount++] = arr[currentIdx];
            currentIdx = (currentIdx + k) % arrSize;
        } while (currentIdx != i);

        if (cycleCount > 0) {
            qsort(cycleElements, cycleCount, sizeof(int), compareInts);

            int median = cycleElements[(cycleCount - 1) / 2];

            for (int j = 0; j < cycleCount; ++j) {
                if (cycleElements[j] != median) {
                    totalChanges++;
                }
            }
        }
    }

    free(cycleElements);

    return totalChanges;
}