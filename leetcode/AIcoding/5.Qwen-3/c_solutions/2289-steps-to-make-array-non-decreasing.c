#include <stdio.h>
#include <stdlib.h>

int totalSteps(int* nums, int numsSize) {
    int* stack = (int*)malloc(sizeof(int) * numsSize);
    int top = -1;
    int result = 0;

    for (int i = 0; i < numsSize; ++i) {
        int count = 0;
        while (top >= 0 && nums[i] >= nums[stack[top]]) {
            count = (count > 0 ? count : 0) + 1;
            --top;
        }
        if (top >= 0) {
            result = (result > count ? result : count);
        }
        stack[++top] = i;
    }

    free(stack);
    return result;
}