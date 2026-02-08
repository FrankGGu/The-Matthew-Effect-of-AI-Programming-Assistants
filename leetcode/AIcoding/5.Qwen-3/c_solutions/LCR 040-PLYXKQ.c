#include <stdio.h>
#include <stdlib.h>

int** createMatrix(int rows, int cols) {
    int** matrix = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        matrix[i] = (int*)malloc(cols * sizeof(int));
    }
    return matrix;
}

void freeMatrix(int** matrix, int rows) {
    for (int i = 0; i < rows; i++) {
        free(matrix[i]);
    }
    free(matrix);
}

int max(int a, int b) {
    return a > b ? a : b;
}

int largestRectangleArea(int* heights, int heightsSize) {
    int* stack = (int*)malloc((heightsSize + 1) * sizeof(int));
    int top = -1;
    int maxArea = 0;
    int i;

    for (i = 0; i < heightsSize; ++i) {
        while (top >= 0 && heights[stack[top]] > heights[i]) {
            int height = heights[stack[top--]];
            int width = top >= 0 ? i - stack[top] - 1 : i;
            maxArea = max(maxArea, height * width);
        }
        stack[++top] = i;
    }

    while (top >= 0) {
        int height = heights[stack[top--]];
        int width = top >= 0 ? i - stack[top] - 1 : i;
        maxArea = max(maxArea, height * width);
    }

    free(stack);
    return maxArea;
}

int maximalRectangle(char** matrix, int matrixRowSize, int matrixColSize) {
    if (matrixRowSize == 0 || matrixColSize == 0) return 0;

    int** heights = createMatrix(matrixRowSize, matrixColSize);
    for (int i = 0; i < matrixRowSize; i++) {
        for (int j = 0; j < matrixColSize; j++) {
            if (matrix[i][j] == '1') {
                heights[i][j] = (i == 0) ? 1 : heights[i-1][j] + 1;
            } else {
                heights[i][j] = 0;
            }
        }
    }

    int maxArea = 0;
    for (int i = 0; i < matrixRowSize; i++) {
        maxArea = max(maxArea, largestRectangleArea(heights[i], matrixColSize));
    }

    freeMatrix(heights, matrixRowSize);
    return maxArea;
}