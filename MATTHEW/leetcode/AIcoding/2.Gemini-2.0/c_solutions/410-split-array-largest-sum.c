#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int splitArray(int* nums, int numsSize, int k) {
    int left = 0, right = 0;
    for (int i = 0; i < numsSize; i++) {
        right += nums[i];
        if (nums[i] > left) {
            left = nums[i];
        }
    }

    int ans = right;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        int count = 1;
        int currentSum = 0;

        for (int i = 0; i < numsSize; i++) {
            if (currentSum + nums[i] <= mid) {
                currentSum += nums[i];
            } else {
                count++;
                currentSum = nums[i];
            }
        }

        if (count <= k) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
}