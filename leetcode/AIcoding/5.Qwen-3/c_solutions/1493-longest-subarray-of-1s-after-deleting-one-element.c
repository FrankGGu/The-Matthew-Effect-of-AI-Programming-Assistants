#include <stdio.h>
#include <stdlib.h>

int longestSubarray(int* nums, int numsSize) {
    int left = 0;
    int maxLen = 0;
    int zeroCount = 0;

    for (int right = 0; right < numsSize; right++) {
        if (nums[right] == 0) {
            zeroCount++;
        }

        while (zeroCount > 1) {
            if (nums[left] == 0) {
                zeroCount--;
            }
            left++;
        }

        maxLen = (maxLen < (right - left)) ? (right - left) : maxLen;
    }

    return maxLen;
}