#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestNiceSubarray(int* nums, int numsSize) {
    int ans = 0;
    int left = 0;
    int currentAnd = 0;
    for (int right = 0; right < numsSize; right++) {
        while ((currentAnd & nums[right]) != 0) {
            currentAnd ^= nums[left];
            left++;
        }
        currentAnd |= nums[right];
        ans = (ans > right - left + 1) ? ans : (right - left + 1);
    }
    return ans;
}