int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

int largestSubmatrix(int** matrix, int matrixSize, int* matrixColSize) {
    int m = matrixSize;
    int n = matrixColSize[0];
    int* heights = (int*)malloc(n * sizeof(int));
    int* temp = (int*)malloc(n * sizeof(int));
    int maxArea = 0;

    for (int i = 0; i < n; i++) {
        heights[i] = 0;
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (matrix[i][j] == 1) {
                heights[j]++;
            } else {
                heights[j] = 0;
            }
            temp[j] = heights[j];
        }

        qsort(temp, n, sizeof(int), cmp);

        for (int j = 0; j < n; j++) {
            int area = temp[j] * (j + 1);
            if (area > maxArea) {
                maxArea = area;
            }
        }
    }

    free(heights);
    free(temp);
    return maxArea;
}