#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* differenceOfDistinctValues(int** grid, int gridSize, int* gridColSize, int* returnSize){
    int rows = gridSize;
    int cols = gridColSize[0];
    *returnSize = rows * cols;
    int *result = (int*)malloc(sizeof(int) * (*returnSize));

    for(int i = 0; i < rows; i++){
        for(int j = 0; j < cols; j++){
            int top_left_count = 0;
            int bottom_right_count = 0;
            int top_left_values[51] = {0};
            int bottom_right_values[51] = {0};

            for(int k = 1; i - k >= 0 && j - k >= 0; k++){
                if(top_left_values[grid[i-k][j-k]] == 0){
                    top_left_values[grid[i-k][j-k]] = 1;
                    top_left_count++;
                }
            }

            for(int k = 1; i + k < rows && j + k < cols; k++){
                if(bottom_right_values[grid[i+k][j+k]] == 0){
                    bottom_right_values[grid[i+k][j+k]] = 1;
                    bottom_right_count++;
                }
            }

            result[i * cols + j] = abs(top_left_count - bottom_right_count);
        }
    }

    return result;
}