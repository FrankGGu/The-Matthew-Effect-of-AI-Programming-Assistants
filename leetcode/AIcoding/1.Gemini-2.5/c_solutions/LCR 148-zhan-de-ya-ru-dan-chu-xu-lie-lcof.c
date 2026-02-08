#include <stdbool.h>
#include <stdlib.h>

bool validateStackSequences(int* pushed, int pushedSize, int* popped, int poppedSize) {
    int* stack = (int*)malloc(sizeof(int) * pushedSize);
    if (stack == NULL) {
        // Handle allocation failure if necessary, though unlikely for typical LeetCode constraints
        return false;
    }
    int top = -1; // Stack pointer, -1 indicates an empty stack

    int popped_idx = 0; // Pointer for the 'popped' array

    for (int i = 0; i < pushedSize; i++) {
        // Push the current element from the 'pushed' array onto the stack
        top++;
        stack[top] = pushed[i];

        // While the stack is not empty and the top of the stack matches the
        // current element in the 'popped' array, pop from the stack.
        while (top >= 0 && stack[top] == popped[popped_idx]) {
            top--; // Pop the element
            popped_idx++; // Move to the next element in the 'popped' array
        }
    }

    // After processing all elements from 'pushed', if the stack is empty,
    // it means all elements were popped in the correct sequence.
    bool result = (top == -1);

    free(stack); // Free the dynamically allocated memory

    return result;
}