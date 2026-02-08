#include <stdio.h>
#include <stdlib.h>

int** differenceOfNoOfOnesAndZeros(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    int rows = gridSize;
    int cols = gridColSize[0];
    *returnSize = rows;
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        (*returnColumnSizes)[i] = cols;
    }
    int** result = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
    }
    int* rowOnes = (int*)calloc(rows, sizeof(int));
    int* colOnes = (int*)calloc(cols, sizeof(int));
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                rowOnes[i]++;
                colOnes[j]++;
            }
        }
    }
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            result[i][j] = rowOnes[i] - (cols - rowOnes[i]) + colOnes[j] - (rows - colOnes[j]);
        }
    }
    free(rowOnes);
    free(colOnes);
    return result;
}