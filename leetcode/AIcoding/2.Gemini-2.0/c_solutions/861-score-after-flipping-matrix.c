#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int matrixScore(int** grid, int gridSize, int* gridColSize){
    int rows = gridSize;
    int cols = gridColSize[0];
    int score = 0;

    for (int i = 0; i < rows; i++) {
        if (grid[i][0] == 0) {
            for (int j = 0; j < cols; j++) {
                grid[i][j] = 1 - grid[i][j];
            }
        }
    }

    for (int j = 0; j < cols; j++) {
        int count = 0;
        for (int i = 0; i < rows; i++) {
            if (grid[i][j] == 0) {
                count++;
            }
        }
        if (count > rows / 2) {
            for (int i = 0; i < rows; i++) {
                grid[i][j] = 1 - grid[i][j];
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        int rowScore = 0;
        for (int j = 0; j < cols; j++) {
            rowScore = (rowScore << 1) + grid[i][j];
        }
        score += rowScore;
    }

    return score;
}