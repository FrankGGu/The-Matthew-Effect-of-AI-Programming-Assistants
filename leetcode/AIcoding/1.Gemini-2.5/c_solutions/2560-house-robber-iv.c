#include <stdbool.h>
#include <limits.h>

bool check(int max_cap, int* nums, int numsSize, int k) {
    int count = 0;
    for (int i = 0; i < numsSize; ) {
        if (nums[i] <= max_cap) {
            count++;
            i += 2;
        } else {
            i++;
        }
        if (count >= k) {
            return true;
        }
    }
    return count >= k;
}

int minCapability(int* nums, int numsSize, int k) {
    int left = INT_MAX;
    int right = INT_MIN;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < left) {
            left = nums[i];
        }
        if (nums[i] > right) {
            right = nums[i];
        }
    }

    int ans = right;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (check(mid, nums, numsSize, k)) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
}