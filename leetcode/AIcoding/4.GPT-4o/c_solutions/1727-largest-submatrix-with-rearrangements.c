int maximalRectangle(char** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || matrixColSize[0] == 0) return 0;

    int maxArea = 0;
    int rows = matrixSize;
    int cols = *matrixColSize;
    int heights[cols];
    memset(heights, 0, sizeof(heights));

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            heights[j] = (matrix[i][j] == '1') ? heights[j] + 1 : 0;
        }
        for (int j = 0; j < cols; j++) {
            if (heights[j] > 0) {
                int width = 1;
                while (j + 1 < cols && heights[j + 1] >= heights[j]) {
                    width++;
                    j++;
                }
                maxArea = fmax(maxArea, heights[j] * width);
            }
        }
    }

    return maxArea;
}