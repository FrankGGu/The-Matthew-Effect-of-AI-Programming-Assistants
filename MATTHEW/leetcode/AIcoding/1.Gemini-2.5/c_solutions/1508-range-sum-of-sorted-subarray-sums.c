#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int rangeSum(int* nums, int numsSize, int left, int right) {
    long long MOD = 1e9 + 7;

    int totalSumsCount = numsSize * (numsSize + 1) / 2;

    int* allSums = (int*)malloc(sizeof(int) * totalSumsCount);

    int currentSumIndex = 0;
    for (int i = 0; i < numsSize; ++i) {
        int currentSubarraySum = 0;
        for (int j = i; j < numsSize; ++j) {
            currentSubarraySum += nums[j];
            allSums[currentSumIndex++] = currentSubarraySum;
        }
    }

    qsort(allSums, totalSumsCount, sizeof(int), compare);

    long long resultSum = 0;
    for (int i = left - 1; i < right; ++i) {
        resultSum = (resultSum + allSums[i]) % MOD;
    }

    free(allSums);

    return (int)resultSum;
}