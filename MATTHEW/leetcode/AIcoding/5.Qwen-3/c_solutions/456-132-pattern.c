#include <stdio.h>
#include <stdlib.h>

bool find132pattern(int* nums, int numsSize) {
    int* stack = (int*)malloc(numsSize * sizeof(int));
    int top = -1;
    int third = INT_MIN;

    for (int i = numsSize - 1; i >= 0; i--) {
        if (nums[i] < third) {
            free(stack);
            return true;
        }
        while (top >= 0 && nums[i] > stack[top]) {
            third = stack[top];
            top--;
        }
        stack[++top] = nums[i];
    }

    free(stack);
    return false;
}