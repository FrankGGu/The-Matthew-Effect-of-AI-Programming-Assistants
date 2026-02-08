#include <stdio.h>
#include <stdlib.h>

int minOperations(int* nums, int numsSize) {
    int operations = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > nums[i - 1]) {
            continue;
        }
        operations += nums[i - 1] - nums[i] + 1;
        nums[i] = nums[i - 1] + 1;
    }
    return operations;
}