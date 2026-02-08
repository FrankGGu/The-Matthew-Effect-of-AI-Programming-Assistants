#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int largestRectangleArea(int* heights, int heightsSize) {
    if (heights == NULL || heightsSize == 0) {
        return 0;
    }

    int maxArea = 0;
    int stack[heightsSize + 1];
    int top = -1;

    for (int i = 0; i <= heightsSize; i++) {
        int currentHeight = (i == heightsSize) ? 0 : heights[i];

        while (top != -1 && currentHeight < heights[stack[top]]) {
            int height = heights[stack[top]];
            top--;
            int width = (top == -1) ? i : (i - stack[top] - 1);
            int area = height * width;
            if (area > maxArea) {
                maxArea = area;
            }
        }
        stack[++top] = i;
    }

    return maxArea;
}

int maximalRectangle(char** matrix, int matrixSize, int* matrixColSize) {
    if (matrix == NULL || matrixSize == 0 || matrixColSize == NULL || *matrixColSize == 0) {
        return 0;
    }

    int rows = matrixSize;
    int cols = *matrixColSize;
    int heights[cols];
    memset(heights, 0, sizeof(heights));
    int maxArea = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] == '1') {
                heights[j]++;
            } else {
                heights[j] = 0;
            }
        }
        int area = largestRectangleArea(heights, cols);
        if (area > maxArea) {
            maxArea = area;
        }
    }

    return maxArea;
}