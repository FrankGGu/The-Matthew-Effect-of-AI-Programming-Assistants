#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* recoverArray(int n, int* sums, int sumsSize, int* returnSize) {
    qsort(sums, sumsSize, sizeof(int), [](const void* a, const void* b) {
        return (*(int*)a - *(int*)b);
    });

    int* ans = (int*)malloc(n * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < n; i++) {
        int diff = sums[1] - sums[0];
        int zeroCount = 0;
        int positiveCount = 0;
        int size = 0;
        int* nextSums = (int*)malloc(sumsSize * sizeof(int));
        bool foundPositive = false;

        for (int j = 0; j < sumsSize; j++) {
            if (sums[j] == 0) {
                zeroCount++;
            }
        }

        int k = 0;
        for (int j = 0; j < sumsSize; j++) {
            if (sums[j] == INT_MIN) continue;
            nextSums[size++] = sums[j];
            for (int l = j + 1; l < sumsSize; l++) {
                if (sums[l] == sums[j] + diff) {
                    sums[l] = INT_MIN;
                    foundPositive = true;
                    break;
                }
            }
            if (!foundPositive) {
                diff = -diff;
                break;
            }
            foundPositive = false;
        }

        ans[(*returnSize)++] = diff;
        sumsSize = size;
        free(sums);
        sums = nextSums;
        qsort(sums, sumsSize, sizeof(int), [](const void* a, const void* b) {
            return (*(int*)a - *(int*)b);
        });
    }

    return ans;
}