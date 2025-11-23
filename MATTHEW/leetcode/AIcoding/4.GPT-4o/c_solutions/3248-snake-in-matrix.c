char* snakeInMatrix(int** matrix, int matrixSize, int* matrixColSize, int* returnSize) {
    int totalElements = matrixSize * (*matrixColSize);
    char* result = malloc(totalElements + 1);
    int index = 0;

    int left = 0, right = *matrixColSize - 1, top = 0, bottom = matrixSize - 1;

    while (left <= right && top <= bottom) {
        for (int i = left; i <= right; i++) {
            result[index++] = matrix[top][i] + '0';
        }
        top++;

        for (int i = top; i <= bottom; i++) {
            result[index++] = matrix[i][right] + '0';
        }
        right--;

        if (top <= bottom) {
            for (int i = right; i >= left; i--) {
                result[index++] = matrix[bottom][i] + '0';
            }
            bottom--;
        }

        if (left <= right) {
            for (int i = bottom; i >= top; i--) {
                result[index++] = matrix[i][left] + '0';
            }
            left++;
        }
    }

    result[index] = '\0';
    *returnSize = totalElements;
    return result;
}