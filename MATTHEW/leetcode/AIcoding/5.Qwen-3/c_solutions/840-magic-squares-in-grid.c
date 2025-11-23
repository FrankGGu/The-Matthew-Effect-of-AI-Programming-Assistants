#include <stdio.h>
#include <stdlib.h>

int isMagicSquare(int** grid, int gridSize, int* gridColSize, int x, int y) {
    int sum = 0;
    for (int i = 0; i < 3; i++) {
        sum += grid[x][y + i];
    }
    for (int i = 0; i < 3; i++) {
        int rowSum = 0;
        for (int j = 0; j < 3; j++) {
            rowSum += grid[x + i][y + j];
        }
        if (rowSum != sum) return 0;
    }
    for (int j = 0; j < 3; j++) {
        int colSum = 0;
        for (int i = 0; i < 3; i++) {
            colSum += grid[x + i][y + j];
        }
        if (colSum != sum) return 0;
    }
    int diag1 = grid[x][y] + grid[x + 1][y + 1] + grid[x + 2][y + 2];
    int diag2 = grid[x][y + 2] + grid[x + 1][y + 1] + grid[x + 2][y];
    if (diag1 != sum || diag2 != sum) return 0;
    int nums[9];
    int index = 0;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            nums[index++] = grid[x + i][y + j];
        }
    }
    for (int i = 0; i < 9; i++) {
        for (int j = i + 1; j < 9; j++) {
            if (nums[i] == nums[j]) return 0;
        }
    }
    for (int i = 0; i < 9; i++) {
        if (nums[i] < 1 || nums[i] > 9) return 0;
    }
    return 1;
}

int numMagicSquaresInGrid(int** grid, int gridSize, int* gridColSize) {
    int count = 0;
    for (int i = 0; i <= gridSize - 3; i++) {
        for (int j = 0; j <= gridColSize[i] - 3; j++) {
            if (isMagicSquare(grid, gridSize, gridColSize, i, j)) {
                count++;
            }
        }
    }
    return count;
}