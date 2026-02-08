#include <stdio.h>
#include <stdlib.h>

int addToConcatedArray(int* nums, int numsSize, int val) {
    int* newNums = (int*)malloc((numsSize + 1) * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        newNums[i] = nums[i];
    }
    newNums[numsSize] = val;
    int result = 0;
    for (int i = 0; i < numsSize + 1; i++) {
        result += newNums[i];
    }
    free(newNums);
    return result;
}