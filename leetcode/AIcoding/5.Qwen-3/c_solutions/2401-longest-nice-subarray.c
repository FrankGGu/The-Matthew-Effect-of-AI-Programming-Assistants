#include <stdio.h>
#include <stdlib.h>

int longestNiceSubarray(int* nums, int numsSize) {
    int maxLen = 0;
    int bitMask = 0;
    int left = 0;

    for (int right = 0; right < numsSize; right++) {
        while (bitMask & nums[right]) {
            bitMask ^= nums[left];
            left++;
        }
        bitMask |= nums[right];
        maxLen = (maxLen > (right - left + 1)) ? maxLen : (right - left + 1);
    }

    return maxLen;
}