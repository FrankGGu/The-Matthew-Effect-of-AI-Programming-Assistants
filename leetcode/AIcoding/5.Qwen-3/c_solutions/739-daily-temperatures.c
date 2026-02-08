#include <stdio.h>
#include <stdlib.h>

int* dailyTemperatures(int* temperatures, int temperaturesSize, int* returnSize) {
    int* result = (int*)malloc(temperaturesSize * sizeof(int));
    int* stack = (int*)malloc(temperaturesSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < temperaturesSize; i++) {
        while (top >= 0 && temperatures[stack[top]] < temperatures[i]) {
            int index = stack[top];
            result[index] = i - index;
            top--;
        }
        stack[++top] = i;
    }

    while (top >= 0) {
        result[stack[top--]] = 0;
    }

    *returnSize = temperaturesSize;
    free(stack);
    return result;
}