int** generateMatrix(int n, int* returnSize, int** returnColumnSizes) {
    int** matrix = (int**)malloc(n * sizeof(int*));
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        matrix[i] = (int*)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = n;
    }
    *returnSize = n;

    int top = 0;
    int bottom = n - 1;
    int left = 0;
    int right = n - 1;
    int num = 1;

    while (top <= bottom && left <= right) {
        // Traverse right
        for (int c = left; c <= right; c++) {
            matrix[top][c] = num++;
        }
        top++;

        // Traverse down
        for (int r = top; r <= bottom; r++) {
            matrix[r][right] = num++;
        }
        right--;

        // Traverse left
        if (top <= bottom) {
            for (int c = right; c >= left; c--) {
                matrix[bottom][c] = num++;
            }
            bottom--;
        }

        // Traverse up
        if (left <= right) {
            for (int r = bottom; r >= top; r--) {
                matrix[r][left] = num++;
            }
            left++;
        }
    }

    return matrix;
}