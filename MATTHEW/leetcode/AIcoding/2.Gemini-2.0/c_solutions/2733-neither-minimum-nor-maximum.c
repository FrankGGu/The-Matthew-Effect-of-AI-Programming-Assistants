#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findNonMinOrMax(int* nums, int numsSize) {
    if (numsSize <= 2) {
        return -1;
    }
    int min_val = nums[0];
    int max_val = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < min_val) {
            min_val = nums[i];
        }
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] != min_val && nums[i] != max_val) {
            return nums[i];
        }
    }
    return -1;
}