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