#include <stdio.h>
#include <stdlib.h>

int longestOnes(int* nums, int numsSize) {
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

        maxLen = (right - left + 1) > maxLen ? (right - left + 1) : maxLen;
    }

    return maxLen;
}