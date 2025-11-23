#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int find(int *parent, int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent, parent[i]);
}

void unite(int *parent, int *size, int i, int j) {
    int rootI = find(parent, i);
    int rootJ = find(parent, j);
    if (rootI != rootJ) {
        parent[rootI] = rootJ;
        size[rootJ] += size[rootI];
    }
}

int* hitBricks(int** grid, int gridSize, int* gridColSize, int** hits, int hitsSize, int* hitsColSize, int* returnSize) {
    int rows = gridSize;
    int cols = *gridColSize;

    int *res = (int*)malloc(sizeof(int) * hitsSize);
    *returnSize = hitsSize;

    for (int i = 0; i < hitsSize; i++) {
        int row = hits[i][0];
        int col = hits[i][1];
        if (grid[row][col] == 1) {
            grid[row][col] = 2;
        }
    }

    int *parent = (int*)malloc(sizeof(int) * (rows * cols + 1));
    int *size = (int*)malloc(sizeof(int) * (rows * cols + 1));

    for (int i = 0; i <= rows * cols; i++) {
        parent[i] = i;
        size[i] = 1;
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                int index = i * cols + j + 1;
                if (i == 0) {
                    unite(parent, size, 0, index);
                }
                if (i > 0 && grid[i - 1][j] == 1) {
                    unite(parent, size, index, (i - 1) * cols + j + 1);
                }
                if (j > 0 && grid[i][j - 1] == 1) {
                    unite(parent, size, index, i * cols + (j - 1) + 1);
                }
            }
        }
    }

    for (int i = hitsSize - 1; i >= 0; i--) {
        int row = hits[i][0];
        int col = hits[i][1];

        if (grid[row][col] == 2) {
            grid[row][col] = 1;
            int index = row * cols + col + 1;
            int originalSize = size[find(parent, 0)];

            if (row == 0) {
                unite(parent, size, 0, index);
            }

            if (row > 0 && grid[row - 1][col] == 1) {
                unite(parent, size, index, (row - 1) * cols + col + 1);
            }
            if (row < rows - 1 && grid[row + 1][col] == 1) {
                unite(parent, size, index, (row + 1) * cols + col + 1);
            }
            if (col > 0 && grid[row][col - 1] == 1) {
                unite(parent, size, index, row * cols + (col - 1) + 1);
            }
            if (col < cols - 1 && grid[row][col + 1] == 1) {
                unite(parent, size, index, row * cols + (col + 1) + 1);
            }

            res[i] = size[find(parent, 0)] - originalSize - 1;
            if (res[i] < 0) {
                res[i] = 0;
            }
        } else {
            res[i] = 0;
        }
    }

    free(parent);
    free(size);

    return res;
}