#include <stdio.h>
#include <stdlib.h>

int canBeIncreasing(int* nums, int numsSize) {
    int count = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] <= nums[i - 1]) {
            count++;
            if (count > 1) return 0;
            if (i > 1 && nums[i] <= nums[i - 2]) {
                nums[i] = nums[i - 1];
            }
        }
    }
    return 1;
}

int checkPossibility(int* nums, int numsSize) {
    return canBeIncreasing(nums, numsSize);
}