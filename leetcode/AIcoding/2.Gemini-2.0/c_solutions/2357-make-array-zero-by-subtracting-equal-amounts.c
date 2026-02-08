#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minimumOperations(int* nums, int numsSize) {
    int operations = 0;
    bool seen[101] = {false};
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0 && !seen[nums[i]]) {
            operations++;
            seen[nums[i]] = true;
        }
    }
    return operations;
}