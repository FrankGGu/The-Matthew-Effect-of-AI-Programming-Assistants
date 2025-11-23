#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int rows;
    int cols;
    int** matrix;
} Matrix;

void flip(int** matrix, int row, int col, int rows, int cols) {
    for (int i = 0; i < 4; i++) {
        int r = row + (i == 0 ? -1 : i == 1 ? 1 : 0);
        int c = col + (i == 2 ? -1 : i == 3 ? 1 : 0);
        if (r >= 0 && r < rows && c >= 0 && c < cols) {
            matrix[r][c] ^= 1;
        }
    }
}

bool isZeroMatrix(int** matrix, int rows, int cols) {
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (matrix[i][j] != 0) return false;
        }
    }
    return true;
}

int dfs(int** matrix, int rows, int cols, int row, int col, int steps) {
    if (isZeroMatrix(matrix, rows, cols)) return steps;
    if (row == rows) return INT_MAX;

    int nextRow = row + (col + 1) / cols;
    int nextCol = (col + 1) % cols;

    int res = dfs(matrix, rows, cols, nextRow, nextCol, steps);

    flip(matrix, row, col, rows, cols);
    int temp = dfs(matrix, rows, cols, nextRow, nextCol, steps + 1);
    flip(matrix, row, col, rows, cols);

    return fmin(res, temp);
}

int minFlips(int** matrix, int matrixSize, int* matrixColSize) {
    int rows = matrixSize;
    int cols = *matrixColSize;
    return dfs(matrix, rows, cols, 0, 0, 0);
}