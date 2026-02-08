int largestRectangleArea(int* heights, int heightsSize) {
    int maxArea = 0;
    int* stack = (int*)malloc(heightsSize * sizeof(int));
    int top = -1;

    for (int i = 0; i <= heightsSize; i++) {
        int h = (i == heightsSize) ? 0 : heights[i];
        while (top != -1 && heights[stack[top]] > h) {
            int height = heights[stack[top--]];
            int width = (top == -1) ? i : i - stack[top] - 1;
            maxArea = fmax(maxArea, height * width);
        }
        stack[++top] = i;
    }

    free(stack);
    return maxArea;
}