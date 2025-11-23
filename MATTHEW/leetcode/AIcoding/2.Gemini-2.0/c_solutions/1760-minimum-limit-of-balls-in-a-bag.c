#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int possible(int *nums, int numsSize, int maxOperations, int mid) {
    int ops = 0;
    for (int i = 0; i < numsSize; i++) {
        ops += (nums[i] - 1) / mid;
    }
    return ops <= maxOperations;
}

int minimumSize(int* nums, int numsSize, int maxOperations) {
    int left = 1;
    int right = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > right) {
            right = nums[i];
        }
    }

    int ans = right;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (possible(nums, numsSize, maxOperations, mid)) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    return ans;
}