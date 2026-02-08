#include <stdbool.h>
#include <stdlib.h>

int countArtifacts(int n, int** artifacts, int artifactsSize, int* artifactsColSize, int** dig, int digSize, int* digColSize) {
    // Dynamically allocate a 2D boolean grid to represent the dug cells.
    // Using calloc ensures all cells are initialized to false (0).
    bool** grid = (bool**)calloc(n, sizeof(bool*));
    for (int i = 0; i < n; i++) {
        grid[i] = (bool*)calloc(n, sizeof(bool));
    }

    // Mark all cells that have been dug.
    for (int i = 0; i < digSize; i++) {
        int r = dig[i][0];
        int c = dig[i][1];
        grid[r][c] = true;
    }

    int extractedArtifactsCount = 0;

    // Iterate through each artifact to check if it can be extracted.
    for (int i = 0; i < artifactsSize; i++) {
        int r1 = artifacts[i][0];
        int c1 = artifacts[i][1];
        int r2 = artifacts[i][2];
        int c2 = artifacts[i][3];

        bool canExtract = true;
        // Check all cells covered by the current artifact.
        for (int r = r1; r <= r2; r++) {
            for (int c = c1; c <= c2; c++) {
                // If any cell of the artifact is not dug, the artifact cannot be extracted.
                if (!grid[r][c]) {
                    canExtract = false;
                    break; // Exit inner loop (columns)
                }
            }
            if (!canExtract) {
                break; // Exit outer loop (rows)
            }
        }

        // If all cells of the artifact were dug, increment the count.
        if (canExtract) {
            extractedArtifactsCount++;
        }
    }

    // Free the dynamically allocated memory for the grid.
    for (int i = 0; i < n; i++) {
        free(grid[i]);
    }
    free(grid);

    return extractedArtifactsCount;
}