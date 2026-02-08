#include <stdio.h>
#include <stdlib.h>

int minOperations(int* nums, int numsSize) {
    int operations = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            operations += nums[i];
            if (i + 1 < numsSize) {
                nums[i + 1] -= nums[i];
            }
        }
    }
    return operations;
}