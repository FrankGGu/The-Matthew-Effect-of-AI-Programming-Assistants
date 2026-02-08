#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int firstMissingPositive(int* nums, int numsSize) {
    int i, temp;

    for (i = 0; i < numsSize; i++) {
        while (nums[i] > 0 && nums[i] <= numsSize && nums[i] != nums[nums[i] - 1]) {
            temp = nums[nums[i] - 1];
            nums[nums[i] - 1] = nums[i];
            nums[i] = temp;
        }
    }

    for (i = 0; i < numsSize; i++) {
        if (nums[i] != i + 1) {
            return i + 1;
        }
    }

    return numsSize + 1;
}