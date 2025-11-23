#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long maxSum(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmp);
    long long sum = 0;
    for (int i = numsSize - k; i < numsSize; i++) {
        sum += nums[i];
    }
    return sum;
}

long long minSum(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmp);
    long long sum = 0;
    for (int i = 0; i < k; i++) {
        sum += nums[i];
    }
    return sum;
}

long long maximumDifference(int* nums, int numsSize, int k) {
    return maxSum(nums, numsSize, k) - minSum(nums, numsSize, k);
}