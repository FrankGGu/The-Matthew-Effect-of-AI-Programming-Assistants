#include <stdio.h>
#include <stdlib.h>

int minOperations(int* nums, int numsSize) {
    int operations = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] != 0) {
            operations += nums[i];
            for (int j = i + 1; j < numsSize; j++) {
                nums[j] -= nums[i];
            }
        }
    }
    return operations;
}