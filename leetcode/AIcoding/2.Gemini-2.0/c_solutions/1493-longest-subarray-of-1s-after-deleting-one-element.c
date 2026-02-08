#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestSubarray(int* nums, int numsSize){
    int left = 0, right = 0;
    int zeroCount = 0;
    int maxLen = 0;

    while (right < numsSize) {
        if (nums[right] == 0) {
            zeroCount++;
        }

        while (zeroCount > 1) {
            if (nums[left] == 0) {
                zeroCount--;
            }
            left++;
        }

        maxLen = (right - left); 
        right++;
    }

    if(maxLen == numsSize){
        return maxLen - 1;
    }

    return maxLen;
}