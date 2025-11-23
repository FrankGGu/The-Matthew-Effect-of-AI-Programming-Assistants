#include <stdlib.h>

int** shiftGrid(int** grid, int gridSize, int* gridColSize, int k, int* returnSize, int** returnColumnSizes) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int totalElements = rows * cols;

    // Reduce k to its effective value within the total number of elements
    k %= totalElements;

    // Allocate memory for the result grid
    int** result = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        result[i] = (int*)malloc(cols * sizeof(int));
    }

    // Set returnSize and returnColumnSizes for the caller
    *returnSize = rows;
    *returnColumnSizes = (int*)malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        (*returnColumnSizes)[i] = cols;
    }

    // Iterate through the original grid and place elements into the new grid
    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            // Calculate the 1D index of the current element
            int originalFlatIndex = r * cols + c;

            // Calculate the new 1D index after shifting
            int newFlatIndex = (originalFlatIndex + k) % totalElements;

            // Convert the new 1D index back to 2D coordinates
            int newR = newFlatIndex / cols;
            int newC = newFlatIndex % cols;

            // Place the element in its new position
            result[newR][newC] = grid[r][c];
        }
    }

    return result;
}