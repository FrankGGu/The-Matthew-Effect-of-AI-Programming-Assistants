#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int smallestDivisor(int* nums, int numsSize, int threshold) {
    int left = 1;
    int right = INT_MIN;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > right) {
            right = nums[i];
        }
    }

    while (left < right) {
        int mid = left + (right - left) / 2;
        int sum = 0;

        for (int i = 0; i < numsSize; i++) {
            sum += (nums[i] + mid - 1) / mid;
        }

        if (sum > threshold) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}