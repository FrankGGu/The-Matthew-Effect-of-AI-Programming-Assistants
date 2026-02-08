#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countSubmatrices(int** grid, int gridSize, int* gridColSize, int x, int y) {
    int count = 0;
    for (int r1 = 0; r1 < gridSize; r1++) {
        for (int c1 = 0; c1 < gridColSize[0]; c1++) {
            for (int r2 = r1; r2 < gridSize; r2++) {
                for (int c2 = c1; c2 < gridColSize[0]; c2++) {
                    int x_count = 0;
                    int y_count = 0;
                    for (int i = r1; i <= r2; i++) {
                        for (int j = c1; j <= c2; j++) {
                            if (grid[i][j] == x) {
                                x_count++;
                            } else if (grid[i][j] == y) {
                                y_count++;
                            }
                        }
                    }
                    if (x_count == y_count) {
                        count++;
                    }
                }
            }
        }
    }
    return count;
}