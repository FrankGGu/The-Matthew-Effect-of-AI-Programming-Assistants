#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int maxWidthRamp(int* nums, int numsSize) {
    if (numsSize < 2) {
        return 0;
    }

    int* stack = (int*)malloc(numsSize * sizeof(int));
    int stackTop = -1; 

    for (int i = 0; i < numsSize; ++i) {
        if (stackTop == -1 || nums[i] < nums[stack[stackTop]]) {
            stack[++stackTop] = i;
        }
    }

    int maxWidth = 0;

    for (int j = numsSize - 1; j >= 0; --j) {
        while (stackTop != -1 && nums[stack[stackTop]] <= nums[j]) {
            maxWidth = max(maxWidth, j - stack[stackTop]);
            stackTop--; 
        }
    }

    free(stack);
    return maxWidth;
}