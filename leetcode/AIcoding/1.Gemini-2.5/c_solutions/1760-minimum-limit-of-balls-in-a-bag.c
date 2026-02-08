#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool check(int* nums, int numsSize, int maxOperations, int limit) {
    long long operationsNeeded = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > limit) {
            operationsNeeded += (nums[i] - 1) / limit;
        }
        // Early exit if operations exceed maxOperations to avoid overflow
        // and unnecessary computation
        if (operationsNeeded > maxOperations) {
            return false;
        }
    }
    return true; // operationsNeeded <= maxOperations
}

int minimumLimit(int* nums, int numsSize, int maxOperations) {
    int left = 1;
    int right = 0; // Max value in nums array
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > right) {
            right = nums[i];
        }
    }

    int ans = right; // Initialize answer with the largest possible limit

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (check(nums, numsSize, maxOperations, mid)) {
            ans = mid;
            right = mid - 1; // Try to find a smaller limit
        } else {
            left = mid + 1; // Current limit 'mid' is too small, need a larger limit
        }
    }

    return ans;
}