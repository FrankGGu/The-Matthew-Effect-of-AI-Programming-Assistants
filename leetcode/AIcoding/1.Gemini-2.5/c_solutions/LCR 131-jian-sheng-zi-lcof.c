#include <stdlib.h> // For qsort
#include <limits.h> // For LLONG_MAX

int compareInt(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

long long minCuts(int* bamboos, int bamboosSize) {
    if (bamboosSize <= 1) {
        return 0;
    }

    qsort(bamboos, bamboosSize, sizeof(int), compareInt);

    long long* suffixSum = (long long*)malloc(bamboosSize * sizeof(long long));
    if (suffixSum == NULL) {
        return -1; // Allocation error
    }

    suffixSum[bamboosSize - 1] = bamboos[bamboosSize - 1];
    for (int i = bamboosSize - 2; i >= 0; --i) {
        suffixSum[i] = bamboos[i] + suffixSum[i + 1];
    }

    long long minTotalCuts = LLONG_MAX;

    for (int i = 0; i < bamboosSize; ++i) {
        long long currentTotalCuts = 0;
        long long targetHeight = bamboos[i];

        if (i < bamboosSize - 1) {
            long long countTaller = (long long)(bamboosSize - 1 - i);
            long long sumTaller = suffixSum[i + 1];
            currentTotalCuts = sumTaller - countTaller * targetHeight;
        }

        if (currentTotalCuts < minTotalCuts) {
            minTotalCuts = currentTotalCuts;
        }
    }

    free(suffixSum);

    return minTotalCuts;
}