#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* arrayChange(int* nums, int numsSize, int** operations, int operationsSize, int* operationsColSize, int* returnSize) {
    int *map = (int*)malloc(sizeof(int) * 100001);
    for (int i = 0; i < numsSize; i++) {
        map[nums[i]] = i;
    }

    for (int i = 0; i < operationsSize; i++) {
        int index = map[operations[i][0]];
        nums[index] = operations[i][1];
        map[operations[i][1]] = index;
    }

    *returnSize = numsSize;
    return nums;
}