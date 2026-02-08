#include <stdio.h>
#include <stdlib.h>

int* mostCompetitive(int* nums, int numsSize, int k, int* returnSize) {
    int* stack = (int*)malloc(k * sizeof(int));
    int top = 0;
    int toPop = numsSize - k;

    for (int i = 0; i < numsSize; i++) {
        while (top > 0 && toPop > 0 && stack[top - 1] > nums[i]) {
            top--;
            toPop--;
        }
        if (top < k) {
            stack[top++] = nums[i];
        } else {
            toPop--;
        }
    }

    *returnSize = k;
    return stack;
}