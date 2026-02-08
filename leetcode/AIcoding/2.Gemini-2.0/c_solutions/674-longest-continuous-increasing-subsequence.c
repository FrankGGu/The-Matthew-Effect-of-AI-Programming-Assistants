#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findLengthOfLCIS(int* nums, int numsSize) {
    if (numsSize == 0) return 0;
    int max_len = 1;
    int curr_len = 1;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > nums[i - 1]) {
            curr_len++;
        } else {
            max_len = (max_len > curr_len) ? max_len : curr_len;
            curr_len = 1;
        }
    }
    max_len = (max_len > curr_len) ? max_len : curr_len;
    return max_len;
}