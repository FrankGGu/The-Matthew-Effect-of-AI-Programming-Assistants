#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long putMarbles(int* weights, int weightsSize, int k) {
    if (k <= 1 || k >= weightsSize) {
        return 0;
    }

    int *pairSums = (int*)malloc(sizeof(int) * (weightsSize - 1));
    for (int i = 0; i < weightsSize - 1; i++) {
        pairSums[i] = weights[i] + weights[i + 1];
    }

    qsort(pairSums, weightsSize - 1, sizeof(int), compare);

    long long minSum = 0;
    long long maxSum = 0;

    for (int i = 0; i < k - 1; i++) {
        minSum += pairSums[i];
        maxSum += pairSums[weightsSize - 2 - i];
    }

    free(pairSums);

    return maxSum - minSum;
}