#include <stdio.h>
#include <stdlib.h>

int splitArray(int* nums, int numsSize, int m) {
    int left = 0, right = 0;
    for (int i = 0; i < numsSize; ++i) {
        left = fmax(left, nums[i]);
        right += nums[i];
    }

    while (left < right) {
        int mid = left + (right - left) / 2;
        int count = 1, current_sum = 0;
        for (int i = 0; i < numsSize; ++i) {
            if (current_sum + nums[i] > mid) {
                count++;
                current_sum = nums[i];
            } else {
                current_sum += nums[i];
            }
        }
        if (count <= m) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
}