#define MAXN 1000

typedef struct {
    int grid[MAXN][MAXN];
    int rows;
    int cols;
} NeighborSumService;

NeighborSumService* neighborSumServiceCreate(int** grid, int gridSize, int* gridColSize) {
    NeighborSumService* service = (NeighborSumService*)malloc(sizeof(NeighborSumService));
    service->rows = gridSize;
    service->cols = *gridColSize;
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < *gridColSize; j++) {
            service->grid[i][j] = grid[i][j];
        }
    }
    return service;
}

int neighborSumServiceGet(NeighborSumService* obj, int row, int col) {
    int sum = 0;
    for (int i = row - 1; i <= row + 1; i++) {
        for (int j = col - 1; j <= col + 1; j++) {
            if (i >= 0 && i < obj->rows && j >= 0 && j < obj->cols && !(i == row && j == col)) {
                sum += obj->grid[i][j];
            }
        }
    }
    return sum;
}

void neighborSumServiceSet(NeighborSumService* obj, int row, int col, int val) {
    obj->grid[row][col] = val;
}

void neighborSumServiceFree(NeighborSumService* obj) {
    free(obj);
}