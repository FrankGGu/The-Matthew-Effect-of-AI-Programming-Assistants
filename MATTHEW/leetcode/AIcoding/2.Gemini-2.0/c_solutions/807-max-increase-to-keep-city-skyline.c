#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxIncreaseKeepingSkyline(int** grid, int gridSize, int* gridColSize){
    int n = gridSize;
    int* rowMax = (int*)malloc(sizeof(int) * n);
    int* colMax = (int*)malloc(sizeof(int) * n);

    for (int i = 0; i < n; i++) {
        rowMax[i] = 0;
        for (int j = 0; j < n; j++) {
            if (grid[i][j] > rowMax[i]) {
                rowMax[i] = grid[i][j];
            }
        }
    }

    for (int j = 0; j < n; j++) {
        colMax[j] = 0;
        for (int i = 0; i < n; i++) {
            if (grid[i][j] > colMax[j]) {
                colMax[j] = grid[i][j];
            }
        }
    }

    int increase = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            int minSkyline = (rowMax[i] < colMax[j]) ? rowMax[i] : colMax[j];
            increase += (minSkyline - grid[i][j]);
        }
    }

    free(rowMax);
    free(colMax);

    return increase;
}