#include <stdio.h>
#include <stdlib.h>

bool searchMatrix(int** matrix, int matrixSize, int* matrixColSize, int target) {
    if (matrix == NULL || matrixSize == 0 || *matrixColSize == 0) {
        return false;
    }

    int rows = matrixSize;
    int cols = *matrixColSize;

    int left = 0;
    int right = rows * cols - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int current = matrix[mid / cols][mid % cols];

        if (current == target) {
            return true;
        } else if (current < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return false;
}