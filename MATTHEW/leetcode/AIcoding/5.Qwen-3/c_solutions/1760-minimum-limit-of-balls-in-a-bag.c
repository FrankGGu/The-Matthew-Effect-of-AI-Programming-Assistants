#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int check(int* nums, int numsSize, int limit) {
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > limit) {
            return 0;
        }
    }
    return 1;
}

int minimizeMax(int* nums, int numsSize, int maxOperations) {
    qsort(nums, numsSize, sizeof(int), compare);

    int left = 0;
    int right = nums[numsSize - 1];

    while (left < right) {
        int mid = left + (right - left) / 2;
        int operations = 0;

        for (int i = 0; i < numsSize - 1; i++) {
            if (nums[i + 1] - nums[i] > mid) {
                operations += (nums[i + 1] - nums[i] - 1) / mid;
            }
        }

        if (operations <= maxOperations) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}