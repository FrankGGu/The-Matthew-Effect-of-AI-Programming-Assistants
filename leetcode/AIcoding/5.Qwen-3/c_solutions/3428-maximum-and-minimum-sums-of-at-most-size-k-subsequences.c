#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long maxSubsequenceSum(int* nums, int numsSize, int k) {
    int* sorted = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i];
    }
    qsort(sorted, numsSize, sizeof(int), compare);

    long long sum = 0;
    for (int i = numsSize - 1; i >= numsSize - k; i--) {
        sum += sorted[i];
    }

    free(sorted);
    return sum;
}

long long minSubsequenceSum(int* nums, int numsSize, int k) {
    int* sorted = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i];
    }
    qsort(sorted, numsSize, sizeof(int), compare);

    long long sum = 0;
    for (int i = 0; i < k; i++) {
        sum += sorted[i];
    }

    free(sorted);
    return sum;
}