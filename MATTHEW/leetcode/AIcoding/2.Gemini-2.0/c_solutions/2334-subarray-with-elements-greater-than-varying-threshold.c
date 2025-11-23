#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool check(int* nums, int numsSize, int threshold, int k) {
    for (int i = 0; i <= numsSize - k; i++) {
        bool valid = true;
        for (int j = i; j < i + k; j++) {
            if (nums[j] <= threshold) {
                valid = false;
                break;
            }
        }
        if (valid) {
            return true;
        }
    }
    return false;
}

int validSubarraySize(int* nums, int numsSize, int threshold) {
    for (int k = 1; k <= numsSize; k++) {
        if (check(nums, numsSize, threshold / k, k)) {
            return k;
        }
    }
    return -1;
}