#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x;
    int y;
} Point;

int dx[4] = {0, 1, 0, -1};
int dy[4] = {1, 0, -1, 0};

int dfs(int** grid, int m, int n, int i, int j, int id) {
    if (i < 0 || j < 0 || i >= m || j >= n || grid[i][j] != 1) return 0;
    grid[i][j] = id;
    int size = 1;
    for (int k = 0; k < 4; k++) {
        size += dfs(grid, m, n, i + dx[k], j + dy[k], id);
    }
    return size;
}

int largestIsland(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = *gridColSize;
    int id = 2;
    int* area = (int*)malloc((m * n + 2) * sizeof(int));
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                area[id] = dfs(grid, m, n, i, j, id);
                id++;
            }
        }
    }

    int maxArea = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 0) {
                int total = 1;
                int visitedId[4] = {0};
                for (int k = 0; k < 4; k++) {
                    int ni = i + dx[k];
                    int nj = j + dy[k];
                    if (ni >= 0 && nj >= 0 && ni < m && nj < n) {
                        int currentId = grid[ni][nj];
                        if (currentId > 1 && !visitedId[currentId]) {
                            total += area[currentId];
                            visitedId[currentId] = 1;
                        }
                    }
                }
                maxArea = (total > maxArea) ? total : maxArea;
            } else {
                maxArea = (area[grid[i][j]] > maxArea) ? area[grid[i][j]] : maxArea;
            }
        }
    }

    free(area);
    return maxArea;
}