#include <math.h>

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

int dfs(int r, int c, int** grid, int rows, int cols) {
    if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == 0) {
        return 0;
    }

    int currentGold = grid[r][c];
    grid[r][c] = 0; 

    int maxCollectedFromNeighbors = 0;
    for (int i = 0; i < 4; ++i) {
        int nr = r + dr[i];
        int nc = c + dc[i];
        maxCollectedFromNeighbors = fmax(maxCollectedFromNeighbors, dfs(nr, nc, grid, rows, cols));
    }

    grid[r][c] = currentGold; 

    return currentGold + maxCollectedFromNeighbors;
}

int getMaximumGold(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    if (rows == 0) {
        return 0;
    }
    int cols = gridColSize[0];
    if (cols == 0) {
        return 0;
    }

    int maxOverallGold = 0;

    for (int r = 0; r < rows; ++r) {
        for (int c = 0; c < cols; ++c) {
            if (grid[r][c] > 0) {
                maxOverallGold = fmax(maxOverallGold, dfs(r, c, grid, rows, cols));
            }
        }
    }

    return maxOverallGold;
}