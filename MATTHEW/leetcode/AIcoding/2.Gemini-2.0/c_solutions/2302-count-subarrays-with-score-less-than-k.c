#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubarrays(int* nums, int numsSize, long long k) {
    int left = 0;
    long long currentSum = 0;
    int count = 0;
    for (int right = 0; right < numsSize; right++) {
        currentSum += nums[right];
        while (left <= right && currentSum * (right - left + 1) >= k) {
            currentSum -= nums[left];
            left++;
        }
        count += (right - left + 1);
    }
    return count;
}