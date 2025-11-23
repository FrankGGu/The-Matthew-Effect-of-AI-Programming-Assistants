#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int largestRectangleArea(int* heights, int heightsSize) {
    int* stack = (int*)malloc(sizeof(int) * (heightsSize + 1));
    int top = -1;
    int maxArea = 0;
    int i;

    for (i = 0; i <= heightsSize; i++) {
        int h = (i == heightsSize) ? 0 : heights[i];
        while (top >= 0 && heights[stack[top]] > h) {
            int height = heights[stack[top--]];
            int width = (top == -1) ? i : i - stack[top] - 1;
            maxArea = max(maxArea, height * width);
        }
        stack[++top] = i;
    }

    free(stack);
    return maxArea;
}

int maximalRectangle(char** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || matrixColSize[0] == 0) return 0;

    int rows = matrixSize;
    int cols = matrixColSize[0];
    int* heights = (int*)malloc(sizeof(int) * cols);
    int maxArea = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] == '1') {
                heights[j]++;
            } else {
                heights[j] = 0;
            }
        }
        maxArea = max(maxArea, largestRectangleArea(heights, cols));
    }

    free(heights);
    return maxArea;
}