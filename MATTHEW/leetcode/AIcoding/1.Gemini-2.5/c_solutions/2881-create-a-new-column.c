#include <stdlib.h>

int** createNewColumn(int** grid, int gridSize, int* gridColSize, int defaultValue, int* returnSize, int** returnColumnSizes) {
    if (gridSize == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int oldNumCols = gridColSize[0];
    int newNumCols = oldNumCols + 1;

    int** newGrid = (int**)malloc(gridSize * sizeof(int*));
    if (newGrid == NULL) {
        return NULL;
    }

    *returnColumnSizes = (int*)malloc(gridSize * sizeof(int));
    if (*returnColumnSizes == NULL) {
        free(newGrid);
        return NULL;
    }

    for (int i = 0; i < gridSize; i++) {
        newGrid[i] = (int*)malloc(newNumCols * sizeof(int));
        if (newGrid[i] == NULL) {
            for (int j = 0; j < i; j++) {
                free(newGrid[j]);
            }
            free(newGrid);
            free(*returnColumnSizes);
            *returnColumnSizes = NULL;
            return NULL;
        }

        for (int j = 0; j < oldNumCols; j++) {
            newGrid[i][j] = grid[i][j];
        }
        newGrid[i][oldNumCols] = defaultValue;

        (*returnColumnSizes)[i] = newNumCols;
    }

    *returnSize = gridSize;
    return newGrid;
}