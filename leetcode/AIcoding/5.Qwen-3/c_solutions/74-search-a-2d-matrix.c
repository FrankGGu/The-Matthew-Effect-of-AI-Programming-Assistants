#include <stdio.h>
#include <stdlib.h>

bool searchMatrix(int** matrix, int matrixRowSize, int matrixColSize, int target) {
    int left = 0;
    int right = matrixRowSize * matrixColSize - 1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int row = mid / matrixColSize;
        int col = mid % matrixColSize;

        if (matrix[row][col] == target) {
            return true;
        } else if (matrix[row][col] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return false;
}