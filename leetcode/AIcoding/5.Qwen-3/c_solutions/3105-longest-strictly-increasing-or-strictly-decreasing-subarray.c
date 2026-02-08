#include <stdio.h>
#include <stdlib.h>

int longestMonotonicSubarray(int* nums, int numsSize) {
    if (numsSize == 0) return 0;

    int maxLen = 1;
    int currentLen = 1;

    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > nums[i-1]) {
            currentLen++;
            maxLen = (currentLen > maxLen) ? currentLen : maxLen;
        } else if (nums[i] < nums[i-1]) {
            currentLen = 1;
        } else {
            currentLen = 1;
        }
    }

    currentLen = 1;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < nums[i-1]) {
            currentLen++;
            maxLen = (currentLen > maxLen) ? currentLen : maxLen;
        } else if (nums[i] > nums[i-1]) {
            currentLen = 1;
        } else {
            currentLen = 1;
        }
    }

    return maxLen;
}