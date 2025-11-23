#include <stdlib.h>

int* findBall(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    int m = gridSize;
    int n = gridColSize[0];

    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = n;

    for (int j = 0; j < n; j++) {
        int currentCol = j;
        for (int i = 0; i < m; i++) {
            int slope = grid[i][currentCol];

            if (slope == 1) { // Right-down slope
                // Check if it hits the right wall or forms a 'V' shape with an adjacent left-down slope
                if (currentCol + 1 >= n || grid[i][currentCol + 1] == -1) {
                    currentCol = -1; // Ball gets stuck
                    break;
                }
                currentCol++; // Move to the right and down
            } else { // slope == -1, Left-down slope
                // Check if it hits the left wall or forms a 'V' shape with an adjacent right-down slope
                if (currentCol - 1 < 0 || grid[i][currentCol - 1] == 1) {
                    currentCol = -1; // Ball gets stuck
                    break;
                }
                currentCol--; // Move to the left and down
            }
        }
        result[j] = currentCol;
    }

    return result;
}