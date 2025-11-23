#include <stdio.h>
#include <stdlib.h>

int** generate(int n) {
    int** result = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        result[i] = (int*)malloc((i + 1) * sizeof(int));
        result[i][0] = 1;
        result[i][i] = 1;
        for (int j = 1; j < i; j++) {
            result[i][j] = result[i - 1][j - 1] + result[i - 1][j];
        }
    }
    return result;
}

int countRightTriangles(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int** pascal = generate(rows + cols);
    int count = 0;
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                int left = 0;
                int right = 0;
                for (int k = 0; k < rows; k++) {
                    if (k != i && grid[k][j] == 1) {
                        left++;
                    }
                }
                for (int k = 0; k < cols; k++) {
                    if (k != j && grid[i][k] == 1) {
                        right++;
                    }
                }
                count += pascal[left + right][left];
            }
        }
    }
    return count;
}