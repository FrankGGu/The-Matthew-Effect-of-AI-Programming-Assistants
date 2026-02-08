#include <stdio.h>
#include <stdlib.h>

int minOperations(int* nums, int numsSize) {
    int operations = 0;
    for (int i = numsSize - 2; i >= 0; i--) {
        if (nums[i] > nums[i + 1]) {
            operations++;
            nums[i] = nums[i + 1];
        }
    }
    return operations;
}