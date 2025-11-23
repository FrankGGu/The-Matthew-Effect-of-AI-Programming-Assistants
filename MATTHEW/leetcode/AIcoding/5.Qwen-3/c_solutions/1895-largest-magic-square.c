#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int isMagic(int** grid, int rows, int cols, int x1, int y1, int size) {
    int sum = 0;
    for (int i = 0; i < size; i++) {
        sum += grid[x1][y1 + i];
    }

    for (int i = 0; i < size; i++) {
        int rowSum = 0;
        for (int j = 0; j < size; j++) {
            rowSum += grid[x1 + i][y1 + j];
        }
        if (rowSum != sum) return 0;
    }

    for (int j = 0; j < size; j++) {
        int colSum = 0;
        for (int i = 0; i < size; i++) {
            colSum += grid[x1 + i][y1 + j];
        }
        if (colSum != sum) return 0;
    }

    int diag1 = 0;
    for (int i = 0; i < size; i++) {
        diag1 += grid[x1 + i][y1 + i];
    }
    if (diag1 != sum) return 0;

    int diag2 = 0;
    for (int i = 0; i < size; i++) {
        diag2 += grid[x1 + i][y1 + size - 1 - i];
    }
    if (diag2 != sum) return 0;

    return 1;
}

int numMagicSquaresInside(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = *gridColSize;
    int max_size = 1;

    for (int size = 2; size <= min(rows, cols); size++) {
        for (int i = 0; i <= rows - size; i++) {
            for (int j = 0; j <= cols - size; j++) {
                if (isMagic(grid, rows, cols, i, j, size)) {
                    max_size = size;
                }
            }
        }
    }

    return max_size;
}