#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long largestPerimeter(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    for (int i = numsSize - 1; i >= 2; i--) {
        sum -= nums[i];
        if (sum > nums[i]) {
            return sum + nums[i];
        }
    }
    return -1;
}