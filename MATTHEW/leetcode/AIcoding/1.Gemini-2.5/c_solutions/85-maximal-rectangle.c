#include <stdlib.h> // Required for calloc and free

int largestRectangleArea(int* heights, int heightsSize) {
    if (heightsSize == 0) {
        return 0;
    }

    int maxA = 0;
    // Stack to store indices of bars
    // The stack size needs to be heightsSize + 1 to accommodate all indices and the sentinel
    int* stack = (int*)malloc((heightsSize + 1) * sizeof(int));
    int top = -1; // Stack top pointer

    for (int i = 0; i <= heightsSize; i++) {
        // Use 0 as a sentinel height at the end to process remaining elements in the stack
        int currentHeight = (i == heightsSize) ? 0 : heights[i];

        while (top != -1 && currentHeight < heights[stack[top]]) {
            int h = heights[stack[top--]]; // Pop the top element
            // Calculate width: if stack is empty, width is 'i', otherwise it's 'i - stack[top] - 1'
            int w = (top == -1) ? i : (i - stack[top] - 1);
            if (h * w > maxA) {
                maxA = h * w;
            }
        }
        stack[++top] = i; // Push current index onto the stack
    }
    free(stack);
    return maxA;
}

int maximalRectangle(char** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || *matrixColSize == 0) {
        return 0;
    }

    int n = *matrixColSize;
    int maxArea = 0;
    // heights array stores the current histogram for the current row
    // It is initialized to zeros by calloc
    int* heights = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < n; j++) {
            if (matrix[i][j] == '1') {
                heights[j]++; // Increment height if '1'
            } else {
                heights[j] = 0; // Reset height to 0 if '0'
            }
        }
        // Calculate the largest rectangle in the current histogram
        int currentMax = largestRectangleArea(heights, n);
        if (currentMax > maxArea) {
            maxArea = currentMax;
        }
    }

    free(heights); // Free allocated memory
    return maxArea;
}