#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int deleteGreatestValue(int** grid, int gridSize, int* gridColSize){
    int sum = 0;
    int cols = gridColSize[0];

    for (int j = 0; j < cols; j++) {
        int max_val = 0;
        for (int i = 0; i < gridSize; i++) {
            int max_in_row = 0;
            int max_index = -1;
            for(int k = 0; k < gridColSize[i]; k++){
                if(grid[i][k] > max_in_row){
                    max_in_row = grid[i][k];
                    max_index = k;
                }
            }
            if(max_index != -1){
                if(max_in_row > max_val){
                    max_val = max_in_row;
                }
                grid[i][max_index] = -1;

                int temp_size = gridColSize[i];
                int *temp = (int*)malloc(sizeof(int) * (temp_size -1));
                int index = 0;
                for(int l = 0; l < temp_size; l++){
                    if(grid[i][l] != -1){
                        temp[index++] = grid[i][l];
                    }
                }
                free(grid[i]);
                grid[i] = temp;
                gridColSize[i]--;
            }
        }
        sum += max_val;
    }

    return sum;
}