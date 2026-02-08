int maximalRectangle(char** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || matrixColSize[0] == 0) return 0;

    int maxArea = 0;
    int* heights = (int*)calloc(*matrixColSize, sizeof(int));

    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < *matrixColSize; j++) {
            heights[j] = (matrix[i][j] == '1') ? heights[j] + 1 : 0;
        }

        int* stack = (int*)malloc((*matrixColSize + 1) * sizeof(int));
        int top = 0;
        stack[top++] = -1;

        for (int j = 0; j <= *matrixColSize; j++) {
            int h = (j == *matrixColSize) ? 0 : heights[j];
            while (top > 1 && heights[stack[top - 1]] >= h) {
                int height = heights[stack[--top]];
                int width = j - stack[top - 1] - 1;
                maxArea = (maxArea > height * width) ? maxArea : height * width;
            }
            stack[top++] = j;
        }

        free(stack);
    }

    free(heights);
    return maxArea;
}