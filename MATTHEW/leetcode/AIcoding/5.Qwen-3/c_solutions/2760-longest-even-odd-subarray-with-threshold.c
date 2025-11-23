#include <stdio.h>
#include <stdlib.h>

int longestAlternatingSubarray(int* nums, int numsSize) {
    int maxLen = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 100) continue;
        int len = 1;
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[j] > 100) break;
            if ((nums[j - 1] % 2) != (nums[j] % 2)) {
                len++;
            } else {
                break;
            }
        }
        if (len > maxLen) {
            maxLen = len;
        }
    }
    return maxLen;
}