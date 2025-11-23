#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestOnes(int* nums, int numsSize, int k) {
    int left = 0, right = 0, zeros = 0, maxLen = 0;
    while (right < numsSize) {
        if (nums[right] == 0) {
            zeros++;
        }
        while (zeros > k) {
            if (nums[left] == 0) {
                zeros--;
            }
            left++;
        }
        maxLen = (right - left + 1) > maxLen ? (right - left + 1) : maxLen;
        right++;
    }
    return maxLen;
}