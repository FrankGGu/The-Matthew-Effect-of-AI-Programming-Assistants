#include <stdlib.h>

int* canSeePersonsCount(int* heights, int heightsSize, int* returnSize) {
    *returnSize = heightsSize;
    int* ans = (int*)malloc(sizeof(int) * heightsSize);
    if (ans == NULL) {
        return NULL; 
    }

    int* stack = (int*)malloc(sizeof(int) * heightsSize);
    if (stack == NULL) {
        free(ans);
        return NULL;
    }
    int stackTop = 0; // Represents the number of elements in the stack

    for (int i = heightsSize - 1; i >= 0; i--) {
        int currentHeight = heights[i];
        int count = 0;

        // Pop elements from the stack that are shorter than the current person.
        // Each popped person is visible to the current person.
        while (stackTop > 0 && stack[stackTop - 1] < currentHeight) {
            stackTop--; // Pop
            count++;
        }

        // If the stack is not empty after popping, the top element is taller
        // than or equal to the current person. This person is also visible.
        if (stackTop > 0) {
            count++;
        }

        ans[i] = count;

        // Push the current person's height onto the stack.
        // The stack maintains elements in decreasing order from bottom to top.
        stack[stackTop] = currentHeight;
        stackTop++;
    }

    free(stack); 
    return ans;
}