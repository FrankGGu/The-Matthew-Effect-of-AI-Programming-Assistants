int maximalRectangle(char** matrix, int matrixSize, int* matrixColSize) {
    if (matrixSize == 0 || matrixColSize[0] == 0) return 0;

    int cols = matrixColSize[0];
    int* heights = (int*)malloc(cols * sizeof(int));
    int* left = (int*)malloc(cols * sizeof(int));
    int* right = (int*)malloc(cols * sizeof(int));
    memset(heights, 0, cols * sizeof(int));

    int maxArea = 0;

    for (int i = 0; i < matrixSize; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] == '1') {
                heights[j]++;
            } else {
                heights[j] = 0;
            }
        }

        for (int j = 0; j < cols; j++) {
            left[j] = j;
            while (left[j] > 0 && heights[left[j] - 1] >= heights[j]) {
                left[j] = left[left[j] - 1];
            }
        }

        for (int j = cols - 1; j >= 0; j--) {
            right[j] = j;
            while (right[j] < cols - 1 && heights[right[j] + 1] >= heights[j]) {
                right[j] = right[right[j] + 1];
            }
        }

        for (int j = 0; j < cols; j++) {
            int area = heights[j] * (right[j] - left[j] + 1);
            if (area > maxArea) {
                maxArea = area;
            }
        }
    }

    free(heights);
    free(left);
    free(right);
    return maxArea;
}