#include <stdio.h>
#include <stdlib.h>

int maxLen(int* nums, int numsSize) {
    int max_len = 0;
    int positive = 0, negative = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == 0) {
            positive = 0;
            negative = 0;
        } else if (nums[i] > 0) {
            positive++;
            negative = (negative == 0) ? 0 : negative + 1;
        } else {
            int temp = positive;
            positive = (negative == 0) ? 0 : negative + 1;
            negative = temp + 1;
        }
        max_len = (max_len < positive) ? positive : max_len;
    }

    return max_len;
}