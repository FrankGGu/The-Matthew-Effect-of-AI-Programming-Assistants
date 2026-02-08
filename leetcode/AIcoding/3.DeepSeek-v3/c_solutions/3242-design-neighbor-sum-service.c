typedef struct {
    int** grid;
    int gridSize;
    int* gridColSize;
} NeighborSum;

NeighborSum* neighborSumCreate(int** grid, int gridSize, int* gridColSize) {
    NeighborSum* obj = (NeighborSum*)malloc(sizeof(NeighborSum));
    obj->grid = grid;
    obj->gridSize = gridSize;
    obj->gridColSize = gridColSize;
    return obj;
}

int neighborSumCalc(NeighborSum* obj, int value) {
    int sum = 0;
    for (int i = 0; i < obj->gridSize; i++) {
        for (int j = 0; j < obj->gridColSize[i]; j++) {
            if (obj->grid[i][j] == value) {
                if (i > 0) sum += obj->grid[i-1][j];
                if (i < obj->gridSize - 1) sum += obj->grid[i+1][j];
                if (j > 0) sum += obj->grid[i][j-1];
                if (j < obj->gridColSize[i] - 1) sum += obj->grid[i][j+1];
            }
        }
    }
    return sum;
}

void neighborSumFree(NeighborSum* obj) {
    free(obj);
}

/**
 * Your NeighborSum struct will be instantiated and called as such:
 * NeighborSum* obj = neighborSumCreate(grid, gridSize, gridColSize);
 * int param_1 = neighborSumCalc(obj, value);

 * neighborSumFree(obj);
*/