#include <stdlib.h>

typedef struct {
    int row;
    int col;
} Point;

typedef struct {
    int key;
    int count;
} HashMap;

int hash(int x, int y) {
    return (x * 1000 + y) % 100003;
}

void illuminate(int** grid, int gridSize, int* gridColSize, Point* points, int pointsSize, int* result) {
    int* rowCount = (int*)calloc(gridSize, sizeof(int));
    int* colCount = (int*)calloc(gridSize, sizeof(int));
    int* diag1Count = (int*)calloc(2 * gridSize, sizeof(int));
    int* diag2Count = (int*)calloc(2 * gridSize, sizeof(int));

    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridColSize[i]; j++) {
            if (grid[i][j] == 1) {
                rowCount[i]++;
                colCount[j]++;
                diag1Count[i - j + gridSize]++;
                diag2Count[i + j]++;
            }
        }
    }

    for (int i = 0; i < pointsSize; i++) {
        int x = points[i].row;
        int y = points[i].col;
        result[i] = (rowCount[x] > 0 || colCount[y] > 0 || diag1Count[x - y + gridSize] > 0 || diag2Count[x + y] > 0) ? 1 : 0;

        if (grid[x][y] == 1) {
            grid[x][y] = 0;
            rowCount[x]--;
            colCount[y]--;
            diag1Count[x - y + gridSize]--;
            diag2Count[x + y]--;
        }

        for (int dx = -1; dx <= 1; dx++) {
            for (int dy = -1; dy <= 1; dy++) {
                if (dx == 0 && dy == 0) continue;
                int nx = x + dx, ny = y + dy;
                if (nx >= 0 && nx < gridSize && ny >= 0 && ny < gridColSize[nx] && grid[nx][ny] == 1) {
                    grid[nx][ny] = 0;
                    rowCount[nx]--;
                    colCount[ny]--;
                    diag1Count[nx - ny + gridSize]--;
                    diag2Count[nx + ny]--;
                }
            }
        }
    }

    free(rowCount);
    free(colCount);
    free(diag1Count);
    free(diag2Count);
}

int* gridIllumination(int** grid, int gridSize, int* gridColSize, Point* lamps, int lampsSize, Point* queries, int queriesSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * queriesSize);
    *returnSize = queriesSize;
    illuminate(grid, gridSize, gridColSize, queries, queriesSize, result);
    return result;
}