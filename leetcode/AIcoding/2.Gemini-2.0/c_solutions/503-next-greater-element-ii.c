#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* nextGreaterElements(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));
    int* stack = (int*)malloc(numsSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < numsSize; i++) {
        result[i] = -1;
    }

    for (int i = 0; i < 2 * numsSize; i++) {
        int num = nums[i % numsSize];
        while (top >= 0 && nums[stack[top]] < num) {
            result[stack[top]] = num;
            top--;
        }
        if (i < numsSize) {
            stack[++top] = i;
        }
    }

    free(stack);
    return result;
}