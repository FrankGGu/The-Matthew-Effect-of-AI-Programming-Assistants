#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximalRectangle(char** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0) return 0;
    int cols = matrixColSize[0];
    int heights[cols];
    for (int i = 0; i < cols; i++) heights[i] = 0;
    int maxArea = 0;

    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] == '1') {
                heights[j]++;
            } else {
                heights[j] = 0;
            }
        }

        int stack[cols];
        int top = -1;
        for (int j = 0; j <= cols; j++) {
            while (top != -1 && (j == cols || heights[stack[top]] >= heights[j])) {
                int height = heights[stack[top]];
                top--;
                int width;
                if (top == -1) {
                    width = j;
                } else {
                    width = j - stack[top] - 1;
                }
                int area = height * width;
                if (area > maxArea) maxArea = area;
            }
            stack[++top] = j;
        }
    }
    return maxArea;
}