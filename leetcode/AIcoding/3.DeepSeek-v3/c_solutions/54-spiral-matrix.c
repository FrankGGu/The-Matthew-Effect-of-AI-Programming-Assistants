int* spiralOrder(int** matrix, int matrixSize, int* matrixColSize, int* returnSize) {
    if (matrixSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int rows = matrixSize;
    int cols = matrixColSize[0];
    *returnSize = rows * cols;
    int* result = (int*)malloc(*returnSize * sizeof(int));

    int top = 0, bottom = rows - 1;
    int left = 0, right = cols - 1;
    int index = 0;

    while (top <= bottom && left <= right) {
        for (int i = left; i <= right; i++) {
            result[index++] = matrix[top][i];
        }
        top++;

        for (int i = top; i <= bottom; i++) {
            result[index++] = matrix[i][right];
        }
        right--;

        if (top <= bottom) {
            for (int i = right; i >= left; i--) {
                result[index++] = matrix[bottom][i];
            }
            bottom--;
        }

        if (left <= right) {
            for (int i = bottom; i >= top; i--) {
                result[index++] = matrix[i][left];
            }
            left++;
        }
    }

    return result;
}