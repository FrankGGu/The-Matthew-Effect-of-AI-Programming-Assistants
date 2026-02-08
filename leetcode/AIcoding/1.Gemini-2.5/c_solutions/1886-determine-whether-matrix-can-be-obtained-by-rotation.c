#include <stdbool.h>

void rotateMatrix(int** matrix, int n) {
    // Transpose the matrix
    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            int temp = matrix[i][j];
            matrix[i][j] = matrix[j][i];
            matrix[j][i] = temp;
        }
    }

    // Reverse each row
    for (int i = 0; i < n; i++) {
        int left = 0;
        int right = n - 1;
        while (left < right) {
            int temp = matrix[i][left];
            matrix[i][left] = matrix[i][right];
            matrix[i][right] = temp;
            left++;
            right--;
        }
    }
}

bool areEqual(int** mat1, int** mat2, int n) {
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            if (mat1[i][j] != mat2[i][j]) {
                return false;
            }
        }
    }
    return true;
}

bool findRotation(int** mat, int matSize, int* matColSize, int** target, int targetSize, int* targetColSize) {
    int n = matSize;

    // Check 0 degrees rotation
    if (areEqual(mat, target, n)) {
        return true;
    }

    // Check 90 degrees rotation
    rotateMatrix(mat, n);
    if (areEqual(mat, target, n)) {
        return true;
    }

    // Check 180 degrees rotation
    rotateMatrix(mat, n);
    if (areEqual(mat, target, n)) {
        return true;
    }

    // Check 270 degrees rotation
    rotateMatrix(mat, n);
    if (areEqual(mat, target, n)) {
        return true;
    }

    return false;
}