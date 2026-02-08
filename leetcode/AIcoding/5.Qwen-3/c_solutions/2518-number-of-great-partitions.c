#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int countGreatPartitions(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    long long total = 0;
    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
    }
    long long leftSum = 0;
    int count = 0;
    for (int i = 0; i < numsSize - 1; i++) {
        leftSum += nums[i];
        if (leftSum > total - leftSum) {
            count++;
        }
    }
    return count;
}