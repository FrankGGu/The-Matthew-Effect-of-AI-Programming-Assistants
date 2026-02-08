#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int equalSubarray(int* nums, int numsSize, int k) {
    int maxLen = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i; j < numsSize; j++) {
            int len = j - i + 1;
            int count = 0;
            for (int l = i; l <= j; l++) {
                if (nums[l] == nums[i]) {
                    count++;
                }
            }
            if (len - count <= k) {
                if (len > maxLen) {
                    maxLen = len;
                }
            }
        }
    }
    return maxLen;
}