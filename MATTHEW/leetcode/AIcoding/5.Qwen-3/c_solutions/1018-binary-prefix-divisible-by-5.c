#include <stdio.h>
#include <stdlib.h>

bool* prefixesDivBy5(int* nums, int numsSize, int* returnSize) {
    bool* result = (bool*)malloc(numsSize * sizeof(bool));
    *returnSize = numsSize;
    int prefix = 0;
    for (int i = 0; i < numsSize; i++) {
        prefix = (prefix * 2 + nums[i]) % 10;
        result[i] = (prefix % 5 == 0);
    }
    return result;
}