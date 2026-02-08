#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool canPartition(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);

    int left = 0;
    int right = numsSize - 1;

    while (left < right) {
        if (nums[right] - nums[left] > k) {
            return false;
        }
        left++;
        right--;
    }

    return true;
}