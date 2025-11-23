#include <stdio.h>
#include <stdlib.h>

long long countSubarrays(int* nums, int numsSize, int k) {
    int n = numsSize;
    long long result = 0;
    int left = 0;
    for (int right = 0; right < n; right++) {
        while (left <= right && nums[right] < nums[left]) {
            left++;
        }
        result += right - left + 1;
    }
    return result;
}