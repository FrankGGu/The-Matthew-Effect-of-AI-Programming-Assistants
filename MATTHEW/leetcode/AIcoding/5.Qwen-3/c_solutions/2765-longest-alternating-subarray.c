#include <stdio.h>
#include <stdlib.h>

int longestAlternatingSubarray(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    int maxLen = 1;
    int currentLen = 1;
    for (int i = 1; i < numsSize; i++) {
        if ((nums[i] > nums[i - 1] && nums[i - 1] < nums[i - 2]) || (nums[i] < nums[i - 1] && nums[i - 1] > nums[i - 2])) {
            currentLen++;
            if (currentLen > maxLen) {
                maxLen = currentLen;
            }
        } else {
            currentLen = 1;
        }
    }
    return maxLen;
}