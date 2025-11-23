#include <stdlib.h> // For malloc and free

static int max(int a, int b) {
    return a > b ? a : b;
}

int largestRectangleArea(int* heights, int heightsSize) {
    if (heightsSize == 0) {
        return 0;
    }

    int maxArea = 0;

    // Stack to store indices of heights
    // Using an array to simulate a stack for efficiency in C
    int* stack = (int*)malloc(sizeof(int) * (heightsSize + 1)); // +1 for potential sentinel push
    int top = -1; // -1 indicates an empty stack

    // Iterate through all heights, and one extra iteration (i == heightsSize)
    // to process any remaining elements in the stack with a '0' height sentinel.
    for (int i = 0; i <= heightsSize; i++) {
        // current_h is the height at current index i, or 0 if i is heightsSize
        int current_h = (i == heightsSize) ? 0 : heights[i];

        // While the stack is not empty and the height at the stack's top
        // is greater than or equal to the current height
        while (top != -1 && heights[stack[top]] >= current_h) {
            int h = heights[stack[top]]; // Height of the popped bar
            top--; // Pop the index from the stack

            int width;
            if (top == -1) {
                // If the stack is empty after popping, it means 'h' is the smallest
                // bar encountered so far, extending from index 0 to i-1.
                // The width is simply 'i'.
                width = i;
            } else {
                // If the stack is not empty, the bar at stack[top] is the first
                // bar to the left that is smaller than 'h'.
                // The width is from stack[top] + 1 to i - 1.
                width = i - stack[top] - 1;
            }
            maxArea = max(maxArea, h * width);
        }

        // Push the current index onto the stack
        top++;
        stack[top] = i;
    }

    free(stack); // Free the dynamically allocated memory for the stack
    return maxArea;
}