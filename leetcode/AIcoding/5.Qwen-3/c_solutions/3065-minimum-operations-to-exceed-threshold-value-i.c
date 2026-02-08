#include <stdio.h>
#include <stdlib.h>

int minOperations(int* nums, int numsSize, int k) {
    int operations = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < k) {
            operations += k - nums[i];
        }
    }
    return operations;
}