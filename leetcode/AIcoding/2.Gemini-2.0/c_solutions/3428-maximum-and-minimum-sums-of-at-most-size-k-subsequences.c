#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long maxSubsequence(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);
    long long sum = 0;
    for (int i = numsSize - k; i < numsSize; i++) {
        sum += nums[i];
    }
    return sum;
}

long long minSubsequence(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);
    long long sum = 0;
    for (int i = 0; i < k; i++) {
        sum += nums[i];
    }
    return sum;
}