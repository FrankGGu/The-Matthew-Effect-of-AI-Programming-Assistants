#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

int** possibleMoves;
int movesSize;
int* movesColSize;

void dfs(int** grid, int gridSize, int* gridColSize, int x, int y, int color, int targetColor) {
    if (x < 0 || x >= gridSize || y < 0 || y >= gridColSize[x] || grid[x][y] != color) {
        return;
    }
    grid[x][y] = targetColor;
    for (int i = 0; i < movesSize; i++) {
        dfs(grid, gridSize, gridColSize, x + possibleMoves[i].x, y + possibleMoves[i].y, color, targetColor);
    }
}

bool canReach(int** grid, int gridSize, int* gridColSize, int x, int y, int targetColor) {
    if (x < 0 || x >= gridSize || y < 0 || y >= gridColSize[x]) {
        return false;
    }
    return grid[x][y] == targetColor;
}

bool isStampsPossible(int** grid, int gridSize, int* gridColSize, int stampSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int** visited = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (int*)malloc(cols * sizeof(int));
        memset(visited[i], 0, cols * sizeof(int));
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 0 && !visited[i][j]) {
                int color = grid[i][j];
                int targetColor = 1;
                dfs(grid, gridSize, gridColSize, i, j, color, targetColor);
                for (int x = 0; x < rows; x++) {
                    for (int y = 0; y < cols; y++) {
                        if (grid[x][y] == 0 && !visited[x][y]) {
                            int count = 0;
                            for (int dx = 0; dx < stampSize; dx++) {
                                for (int dy = 0; dy < stampSize; dy++) {
                                    if (canReach(grid, gridSize, gridColSize, x + dx, y + dy, 1)) {
                                        count++;
                                    }
                                }
                            }
                            if (count < stampSize * stampSize) {
                                for (int x2 = 0; x2 < rows; x2++) {
                                    for (int y2 = 0; y2 < cols; y2++) {
                                        if (grid[x2][y2] == 1) {
                                            grid[x2][y2] = 0;
                                        }
                                    }
                                }
                                return false;
                            }
                        }
                    }
                }
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 0) {
                return false;
            }
        }
    }

    return true;
}

bool possibleToStamp(int** grid, int gridSize, int* gridColSize, int stampSize) {
    int rows = gridSize;
    int cols = gridColSize[0];

    possibleMoves = (Point*)malloc(4 * sizeof(Point));
    possibleMoves[0] = (Point){0, 1};
    possibleMoves[1] = (Point){1, 0};
    possibleMoves[2] = (Point){0, -1};
    possibleMoves[3] = (Point){-1, 0};
    movesSize = 4;
    movesColSize = (int*)malloc(1 * sizeof(int));
    movesColSize[0] = 4;

    int** tempGrid = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        tempGrid[i] = (int*)malloc(cols * sizeof(int));
        memcpy(tempGrid[i], grid[i], cols * sizeof(int));
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (tempGrid[i][j] == 0) {
                int color = tempGrid[i][j];
                int targetColor = 1;
                dfs(tempGrid, rows, gridColSize, i, j, color, targetColor);
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (tempGrid[i][j] == 0) {
                return false;
            }
        }
    }

    return true;
}