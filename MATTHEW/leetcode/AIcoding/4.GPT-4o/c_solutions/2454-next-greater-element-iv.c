#include <stdio.h>
#include <stdlib.h>

int* nextGreaterElements(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int* stack = (int*)malloc(numsSize * sizeof(int));
    int top = -1;
    *returnSize = numsSize;

    for (int i = 0; i < numsSize; i++) {
        result[i] = -1;
    }

    for (int i = 0; i < 2 * numsSize; i++) {
        while (top >= 0 && nums[stack[top]] < nums[i % numsSize]) {
            result[stack[top--]] = nums[i % numsSize];
        }
        if (i < numsSize) {
            stack[++top] = i;
        }
    }

    free(stack);
    return result;
}