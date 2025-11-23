#include <stdio.h>
#include <stdlib.h>

int findValidSplit(int* nums, int numsSize) {
    long long prefix = 0;
    long long suffix = 0;
    for (int i = 0; i < numsSize; i++) {
        suffix += nums[i];
    }
    for (int i = 0; i < numsSize - 1; i++) {
        prefix += nums[i];
        suffix -= nums[i];
        if (prefix == suffix) {
            return i;
        }
    }
    return -1;
}