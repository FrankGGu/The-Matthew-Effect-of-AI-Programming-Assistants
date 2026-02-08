#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxIncreasingGroups(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), cmp);
    long long sum = 0;
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
        if (sum >= (long long)(count + 1) * (count + 2) / 2) {
            count++;
        }
    }
    return count;
}