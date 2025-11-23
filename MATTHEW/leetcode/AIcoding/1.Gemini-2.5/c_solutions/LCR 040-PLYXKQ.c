#include <stdlib.h> // For malloc, free, calloc

static int largestRectangleArea(int* heights, int heightsSize) {
    if (heightsSize == 0) {
        return 0;
    }

    int* stack = (int*)malloc(sizeof(int) * heightsSize);
    int top = -1; // Stack top index
    int max_area = 0;
    int i = 0;

    while (i < heightsSize) {
        if (top == -1 || heights[stack[top]] <= heights[i]) {
            stack[++top] = i++;
        } else {
            int h = heights[stack[top--]];
            int width = (top == -1) ? i : (i - stack[top] - 1);
            if (h * width > max_area) {
                max_area = h * width;
            }
        }
    }

    while (top != -1) {
        int h = heights[stack[top--]];
        int width = (top == -1) ? i : (i - stack[top] - 1);
        if (h * width > max_area) {
            max_area = h * width;
        }
    }

    free(stack);
    return max_area;
}

int maximalRectangle(char** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || *matrixColSize == 0) {
        return 0;
    }

    int cols = *matrixColSize;
    int max_overall_area = 0;

    int* heights = (int*)calloc(cols, sizeof(int));

    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] == '1') {
                heights[j]++;
            } else {
                heights[j] = 0;
            }
        }
        int current_row_max_area = largestRectangleArea(heights, cols);
        if (current_row_max_area > max_overall_area) {
            max_overall_area = current_row_max_area;
        }
    }

    free(heights);
    return max_overall_area;
}