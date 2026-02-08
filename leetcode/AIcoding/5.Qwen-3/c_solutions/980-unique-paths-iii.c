#include <stdio.h>
#include <stdlib.h>

int** grid;
int rows, cols;
int total_steps;
int result;

void backtrack(int x, int y, int steps) {
    if (x < 0 || y < 0 || x >= rows || y >= cols || grid[x][y] == -1) return;

    if (grid[x][y] == 2) {
        if (steps == total_steps) result++;
        return;
    }

    int temp = grid[x][y];
    grid[x][y] = -1;

    backtrack(x + 1, y, steps + 1);
    backtrack(x - 1, y, steps + 1);
    backtrack(x, y + 1, steps + 1);
    backtrack(x, y - 1, steps + 1);

    grid[x][y] = temp;
}

int uniquePathsIII(int** grid, int gridSize, int* gridColSize) {
    rows = gridSize;
    cols = gridColSize[0];
    total_steps = 0;
    result = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                grid[i][j] = 0;
                backtrack(i, j, 1);
            } else if (grid[i][j] == 0) {
                total_steps++;
            }
        }
    }

    return result;
}