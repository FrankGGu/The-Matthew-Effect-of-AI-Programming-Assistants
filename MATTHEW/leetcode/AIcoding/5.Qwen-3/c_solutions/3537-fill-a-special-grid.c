#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int** grid;
    int gridSize;
    int* gridColSize;
} Solution;

Solution* solutionCreate() {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->grid = NULL;
    obj->gridSize = 0;
    obj->gridColSize = NULL;
    return obj;
}

void solutionFree(Solution* obj) {
    for (int i = 0; i < obj->gridSize; i++) {
        free(obj->grid[i]);
    }
    free(obj->grid);
    free(obj->gridColSize);
    free(obj);
}

void fillGrid(int** grid, int gridSize, int* gridColSize, int row, int col, int val) {
    if (row >= gridSize || col >= gridColSize[row] || grid[row][col] != -1) return;
    grid[row][col] = val;
    fillGrid(grid, gridSize, gridColSize, row + 1, col, val);
    fillGrid(grid, gridSize, gridColSize, row, col + 1, val);
    fillGrid(grid, gridSize, gridColSize, row - 1, col, val);
    fillGrid(grid, gridSize, gridColSize, row, col - 1, val);
}

int** specialGrid(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int** result = (int**)malloc(gridSize * sizeof(int*));
    *returnColumnSizes = (int*)malloc(gridSize * sizeof(int));
    for (int i = 0; i < gridSize; i++) {
        result[i] = (int*)malloc(gridColSize[i] * sizeof(int));
        (*returnColumnSizes)[i] = gridColSize[i];
    }

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] == -1) {
                fillGrid(grid, gridSize, gridColSize, i, j, 1);
            }
        }
    }

    *returnSize = gridSize;
    return result;
}