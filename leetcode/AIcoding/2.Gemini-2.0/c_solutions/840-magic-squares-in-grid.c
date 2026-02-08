#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isMagicSquare(int grid[][3]) {
    int sum = grid[0][0] + grid[0][1] + grid[0][2];

    for (int i = 0; i < 3; i++) {
        if (grid[i][0] + grid[i][1] + grid[i][2] != sum) return false;
        if (grid[0][i] + grid[1][i] + grid[2][i] != sum) return false;
    }

    if (grid[0][0] + grid[1][1] + grid[2][2] != sum) return false;
    if (grid[0][2] + grid[1][1] + grid[2][0] != sum) return false;

    bool present[10] = {false};
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            int num = grid[i][j];
            if (num < 1 || num > 9 || present[num]) return false;
            present[num] = true;
        }
    }

    return true;
}

int numMagicSquaresInside(int** grid, int gridSize, int* gridColSize){
    int count = 0;
    if (gridSize < 3 || gridColSize[0] < 3) return 0;

    for (int i = 0; i <= gridSize - 3; i++) {
        for (int j = 0; j <= gridColSize[0] - 3; j++) {
            int subgrid[3][3];
            for (int x = 0; x < 3; x++) {
                for (int y = 0; y < 3; y++) {
                    subgrid[x][y] = grid[i + x][j + y];
                }
            }
            if (isMagicSquare(subgrid)) count++;
        }
    }

    return count;
}