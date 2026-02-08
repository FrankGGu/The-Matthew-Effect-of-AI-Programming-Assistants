#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumDifferenceScore(int** grid, int gridSize, int* gridColSize){
    int rows = gridSize;
    int cols = gridColSize[0];
    int maxDiff = -1;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            int current = grid[i][j];
            int maxGreater = -1;

            for (int r = 0; r < rows; r++) {
                for (int c = 0; c < cols; c++) {
                    if (r == i && c == j) continue;
                    if (grid[r][c] > current) {
                        if (maxGreater == -1 || grid[r][c] < maxGreater) {
                            maxGreater = grid[r][c];
                        }
                    }
                }
            }

            if (maxGreater != -1) {
                int diff = maxGreater - current;
                if (diff > maxDiff) {
                    maxDiff = diff;
                }
            }
        }
    }

    return maxDiff;
}