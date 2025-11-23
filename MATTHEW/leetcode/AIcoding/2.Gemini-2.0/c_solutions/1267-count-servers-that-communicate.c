#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countServers(int** grid, int gridSize, int* gridColSize){
    int rows = gridSize;
    int cols = gridColSize[0];
    int count = 0;
    int* row_counts = (int*)calloc(rows, sizeof(int));
    int* col_counts = (int*)calloc(cols, sizeof(int));
    int i, j;

    for(i = 0; i < rows; i++){
        for(j = 0; j < cols; j++){
            if(grid[i][j] == 1){
                row_counts[i]++;
                col_counts[j]++;
            }
        }
    }

    for(i = 0; i < rows; i++){
        for(j = 0; j < cols; j++){
            if(grid[i][j] == 1){
                if(row_counts[i] > 1 || col_counts[j] > 1){
                    count++;
                }
            }
        }
    }

    free(row_counts);
    free(col_counts);

    return count;
}