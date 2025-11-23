#include <stdlib.h>

int** modifyColumns(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    *returnSize = gridSize;
    *returnColumnSizes = (int*) malloc(sizeof(int) * gridSize);

    int** result = (int**) malloc(sizeof(int*) * gridSize);

    for (int r = 0; r < gridSize; r++) {
        int originalColSize = gridColSize[r];
        (*returnColumnSizes)[r] = originalColSize;
        result[r] = (int*) malloc(sizeof(int) * originalColSize);

        for (int c = 0; c < originalColSize; c++) {
            int currentVal = grid[r][c];
            if (currentVal % 2 == 0) {
                result[r][c] = currentVal + 1;
            } else {
                result[r][c] = currentVal - 1;
            }
        }
    }

    return result;
}