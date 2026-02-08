#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int** grid;
    int rows;
    int cols;
} NeighborSum;

NeighborSum* neighborSumCreate(int** grid, int gridSize, int* gridColSize) {
    NeighborSum* obj = (NeighborSum*)malloc(sizeof(NeighborSum));
    obj->rows = gridSize;
    obj->cols = gridColSize[0];
    obj->grid = (int**)malloc(gridSize * sizeof(int*));
    for (int i = 0; i < gridSize; i++) {
        obj->grid[i] = (int*)malloc(gridColSize[i] * sizeof(int));
        for (int j = 0; j < gridColSize[i]; j++) {
            obj->grid[i][j] = grid[i][j];
        }
    }
    return obj;
}

int neighborSumValue(NeighborSum* obj, int r, int c) {
    int sum = 0;
    int dr[] = {-1, 0, 1, 0};
    int dc[] = {0, 1, 0, -1};
    for (int i = 0; i < 4; i++) {
        int nr = r + dr[i];
        int nc = c + dc[i];
        if (nr >= 0 && nr < obj->rows && nc >= 0 && nc < obj->cols) {
            sum += obj->grid[nr][nc];
        }
    }
    return sum;
}

void neighborSumFree(NeighborSum* obj) {
    for (int i = 0; i < obj->rows; i++) {
        free(obj->grid[i]);
    }
    free(obj->grid);
    free(obj);
}