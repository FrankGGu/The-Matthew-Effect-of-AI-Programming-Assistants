#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sum_division(int* nums, int numsSize, int divisor) {
    int sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += (nums[i] + divisor - 1) / divisor;
    }
    return sum;
}

int smallestDivisor(int* nums, int numsSize, int threshold){
    int left = 1;
    int right = 1000000;
    int ans = right;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (sum_division(nums, numsSize, mid) <= threshold) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
}