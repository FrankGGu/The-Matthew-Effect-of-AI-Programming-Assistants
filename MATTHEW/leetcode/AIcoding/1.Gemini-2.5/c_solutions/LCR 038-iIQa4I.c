#include <stdlib.h>

int* dailyTemperatures(int* temperatures, int temperaturesSize, int* returnSize) {
    int* ans = (int*)malloc(temperaturesSize * sizeof(int));
    for (int i = 0; i < temperaturesSize; i++) {
        ans[i] = 0;
    }

    int* stack = (int*)malloc(temperaturesSize * sizeof(int));
    int stack_top = -1; // Represents an empty stack

    for (int i = 0; i < temperaturesSize; i++) {
        while (stack_top != -1 && temperatures[stack[stack_top]] < temperatures[i]) {
            int prev_idx = stack[stack_top--];
            ans[prev_idx] = i - prev_idx;
        }
        stack[++stack_top] = i;
    }

    *returnSize = temperaturesSize;
    free(stack);
    return ans;
}