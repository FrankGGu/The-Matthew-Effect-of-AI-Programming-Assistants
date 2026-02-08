#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int largestRectangleArea(int* heights, int heightsSize) {
    if (heightsSize == 0) return 0;

    int *stack = (int*)malloc(sizeof(int) * (heightsSize + 1));
    int top = -1;
    int maxArea = 0;

    for (int i = 0; i <= heightsSize; i++) {
        int h = (i == heightsSize) ? 0 : heights[i];
        while (top >= 0 && h < heights[stack[top]]) {
            int height = heights[stack[top]];
            top--;
            int width = (top < 0) ? i : (i - stack[top] - 1);
            int area = height * width;
            if (area > maxArea) {
                maxArea = area;
            }
        }
        stack[++top] = i;
    }

    free(stack);
    return maxArea;
}