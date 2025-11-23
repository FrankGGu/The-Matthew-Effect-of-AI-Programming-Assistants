#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxSum(int** grid, int gridSize, int* gridColSize){
    int max_sum = -1;
    for (int i = 0; i < gridSize - 2; i++) {
        for (int j = 0; j < gridColSize[0] - 2; j++) {
            int current_sum = grid[i][j] + grid[i][j+1] + grid[i][j+2] +
                              grid[i+1][j+1] +
                              grid[i+2][j] + grid[i+2][j+1] + grid[i+2][j+2];
            if (max_sum == -1 || current_sum > max_sum) {
                max_sum = current_sum;
            }
        }
    }
    return max_sum;
}