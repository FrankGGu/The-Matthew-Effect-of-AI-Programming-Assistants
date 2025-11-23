int maximalRectangle(char** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || matrixColSize[0] == 0) return 0;

    int maxArea = 0;
    int* heights = (int*)calloc(*matrixColSize, sizeof(int));

    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < *matrixColSize; j++) {
            heights[j] = (matrix[i][j] == '1') ? heights[j] + 1 : 0;
        }

        int area = largestRectangleArea(heights, *matrixColSize);
        if (area > maxArea) maxArea = area;
    }

    free(heights);
    return maxArea;
}

int largestRectangleArea(int* heights, int heightsSize) {
    int maxArea = 0;
    int* stack = (int*)malloc((heightsSize + 1) * sizeof(int));
    int top = -1;

    for (int i = 0; i <= heightsSize; i++) {
        int h = (i == heightsSize) ? 0 : heights[i];
        while (top != -1 && heights[stack[top]] > h) {
            int height = heights[stack[top--]];
            int width = (top == -1) ? i : i - stack[top] - 1;
            maxArea = (maxArea > height * width) ? maxArea : height * width;
        }
        stack[++top] = i;
    }

    free(stack);
    return maxArea;
}