#include <stdio.h>
#include <stdlib.h>

int largestRectangleArea(int* heights, int heightsSize) {
    int maxArea = 0;
    int* stack = (int*)malloc(sizeof(int) * (heightsSize + 1));
    int top = -1;
    int i;

    for (i = 0; i <= heightsSize; i++) {
        int h = (i == heightsSize) ? 0 : heights[i];
        while (top >= 0 && heights[stack[top]] > h) {
            int height = heights[stack[top--]];
            int width = (top >= 0) ? i - stack[top] - 1 : i;
            maxArea = (maxArea < height * width) ? height * width : maxArea;
        }
        stack[++top] = i;
    }

    free(stack);
    return maxArea;
}