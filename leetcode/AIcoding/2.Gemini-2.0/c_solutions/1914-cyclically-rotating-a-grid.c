#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** rotateGrid(int** grid, int gridSize, int* gridColSize, int k) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int layers = (rows < cols ? rows : cols) / 2;

    for (int layer = 0; layer < layers; layer++) {
        int perimeter = 2 * (rows - 2 * layer) + 2 * (cols - 2 * layer) - 4;
        int rotations = k % perimeter;

        for (int r = 0; r < rotations; r++) {
            int temp = grid[layer][layer];

            // Move values from left to top
            for (int i = layer; i < rows - layer - 1; i++) {
                grid[i][layer] = grid[i + 1][layer];
            }

            // Move values from bottom to left
            for (int j = layer; j < cols - layer - 1; j++) {
                grid[rows - layer - 1][j] = grid[rows - layer - 1][j + 1];
            }

            // Move values from right to bottom
            for (int i = rows - layer - 1; i > layer; i--) {
                grid[i][cols - layer - 1] = grid[i - 1][cols - layer - 1];
            }

            // Move values from top to right
            for (int j = cols - layer - 1; j > layer + 1; j--) {
                grid[layer][j] = grid[layer][j - 1];
            }

            grid[layer][layer + 1] = temp;
        }
    }

    return grid;
}