#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minOperations(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);
    int mid = numsSize / 2;
    int operations = 0;
    if (nums[mid] < k) {
        for (int i = mid; i < numsSize; i++) {
            if (nums[i] < k) {
                operations += (k - nums[i]);
            } else {
                break;
            }
        }
    } else {
        for (int i = mid; i >= 0; i--) {
            if (nums[i] > k) {
                operations += (nums[i] - k);
            } else {
                break;
            }
        }
    }
    return operations;
}