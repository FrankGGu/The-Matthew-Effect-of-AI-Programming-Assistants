#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* mostCompetitive(int* nums, int numsSize, int k, int* returnSize) {
    int* stack = (int*)malloc(k * sizeof(int));
    int top = -1;

    for (int i = 0; i < numsSize; i++) {
        while (top >= 0 && nums[i] < stack[top] && (numsSize - i + top >= k)) {
            top--;
        }
        if (top < k - 1) {
            stack[++top] = nums[i];
        }
    }

    *returnSize = k;
    return stack;
}