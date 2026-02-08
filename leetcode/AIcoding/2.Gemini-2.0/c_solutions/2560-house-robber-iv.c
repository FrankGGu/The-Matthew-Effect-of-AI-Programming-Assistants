#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool canRob(int *nums, int numsSize, int k, int maxRob) {
    int count = 0;
    bool robbedPrev = false;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] <= maxRob) {
            if (!robbedPrev) {
                count++;
                robbedPrev = true;
            } else {
                robbedPrev = false;
            }
        } else {
            robbedPrev = false;
        }
    }
    return count >= k;
}

int minCapability(int *nums, int numsSize, int k) {
    int left = 0;
    int right = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > right) {
            right = nums[i];
        }
    }

    int ans = right;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (canRob(nums, numsSize, k, mid)) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    return ans;
}