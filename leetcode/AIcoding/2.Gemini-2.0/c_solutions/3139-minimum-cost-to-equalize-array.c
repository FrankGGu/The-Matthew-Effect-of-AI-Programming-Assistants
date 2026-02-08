#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minCost(int* nums, int numsSize, int* cost, int costSize) {
    long long left = nums[0];
    long long right = nums[0];
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < left) {
            left = nums[i];
        }
        if (nums[i] > right) {
            right = nums[i];
        }
    }

    while (left < right) {
        long long mid = left + (right - left) / 2;
        long long cost1 = 0, cost2 = 0;
        for (int i = 0; i < numsSize; i++) {
            cost1 += abs(nums[i] - mid) * (long long)cost[i];
            cost2 += abs(nums[i] - (mid + 1)) * (long long)cost[i];
        }

        if (cost1 < cost2) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    long long ans = 0;
    for (int i = 0; i < numsSize; i++) {
        ans += abs(nums[i] - left) * (long long)cost[i];
    }

    return (int)ans;
}