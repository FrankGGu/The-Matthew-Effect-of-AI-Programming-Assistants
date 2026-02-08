#include <stdio.h>
#include <stdlib.h>

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int* getFinalArray(int* nums, int numsSize, int* resultSize) {
    int* stack = (int*)malloc(numsSize * sizeof(int));
    int top = -1;
    int* res = (int*)malloc(numsSize * sizeof(int));
    int resIdx = 0;

    for (int i = 0; i < numsSize; i++) {
        while (top >= 0 && nums[i] < stack[top]) {
            top--;
        }
        if (top >= 0) {
            res[resIdx++] = stack[top];
        } else {
            res[resIdx++] = -1;
        }
        stack[++top] = nums[i];
    }

    *resultSize = resIdx;
    return res;
}