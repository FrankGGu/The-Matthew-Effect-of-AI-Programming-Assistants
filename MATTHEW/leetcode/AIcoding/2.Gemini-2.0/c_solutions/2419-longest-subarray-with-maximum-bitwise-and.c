#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findLength(int* nums, int numsSize){
    int max_val = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    int max_len = 0;
    int curr_len = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == max_val) {
            curr_len++;
            if (curr_len > max_len) {
                max_len = curr_len;
            }
        } else {
            curr_len = 0;
        }
    }

    return max_len;
}