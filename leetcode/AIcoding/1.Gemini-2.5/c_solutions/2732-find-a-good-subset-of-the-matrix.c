#include <stdlib.h> // For malloc
#include <string.h> // For memset

int* goodSubsetofBinaryMatrix(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    int m = gridSize;
    int n = gridColSize[0];

    // Step 1: Check for a single row of all zeros
    // If such a row exists, it forms a good subset of size 1.
    // For k=1, floor(k/2) = 0. So sum of elements in each column must be 0.
    // This means the row must contain only zeros.
    for (int i = 0; i < m; ++i) {
        int current_mask = 0;
        for (int j = 0; j < n; ++j) {
            if (grid[i][j] == 1) {
                current_mask |= (1 << j);
            }
        }
        if (current_mask == 0) {
            int* result = (int*)malloc(sizeof(int));
            result[0] = i;
            *returnSize = 1;
            return result;
        }
    }

    // Step 2 & 3: Find two rows whose masks have a bitwise AND of 0
    // If such a pair (r1, r2) exists, it forms a good subset of size 2.
    // For k=2, floor(k/2) = 1. So sum of elements in each column must be <= 1.
    // This means for any column j, grid[r1][j] + grid[r2][j] <= 1.
    // This is equivalent to (mask(r1) & mask(r2)) == 0.

    // Store the first occurrence of each unique row mask.
    // The maximum possible mask value is (1 << n) - 1.
    // So, an array of size (1 << n) is sufficient.
    int max_mask_val = (1 << n);
    int* first_occurrence = (int*)malloc(max_mask_val * sizeof(int));
    // Initialize with -1 to indicate no occurrence yet
    memset(first_occurrence, -1, max_mask_val * sizeof(int));

    // Populate first_occurrence array
    for (int i = 0; i < m; ++i) {
        int current_mask = 0;
        for (int j = 0; j < n; ++j) {
            if (grid[i][j] == 1) {
                current_mask |= (1 << j);
            }
        }

        // If this mask hasn't been seen before, record its first occurrence
        if (first_occurrence[current_mask] == -1) {
            first_occurrence[current_mask] = i;
        }
    }

    // Iterate through all possible pairs of masks
    for (int mask1 = 0; mask1 < max_mask_val; ++mask1) {
        if (first_occurrence[mask1] == -1) {
            continue; // mask1 pattern was not found in the grid
        }
        // Iterate mask2 from mask1 + 1 to avoid redundant checks and self-comparison.
        // If mask1 == mask2, then (mask1 & mask2) == mask1. For this to be 0, mask1 must be 0.
        // But the case mask1 == 0 (all-zero row) is handled in Step 1.
        // So, if we reach here, mask1 != 0, and thus mask1 & mask1 != 0.
        // Therefore, any valid pair (mask1, mask2) with (mask1 & mask2) == 0 must have mask1 != mask2.
        for (int mask2 = mask1 + 1; mask2 < max_mask_val; ++mask2) {
            if (first_occurrence[mask2] == -1) {
                continue; // mask2 pattern was not found in the grid
            }

            // If their bitwise AND is 0, they form a good subset of size 2
            if ((mask1 & mask2) == 0) {
                int* result = (int*)malloc(2 * sizeof(int));
                // The problem asks for any such subset, order of indices doesn't matter.
                // We can return them in ascending order of their row indices.
                if (first_occurrence[mask1] < first_occurrence[mask2]) {
                    result[0] = first_occurrence[mask1];
                    result[1] = first_occurrence[mask2];
                } else {
                    result[0] = first_occurrence[mask2];
                    result[1] = first_occurrence[mask1];
                }
                *returnSize = 2;
                free(first_occurrence); // Free dynamically allocated memory
                return result;
            }
        }
    }

    // If no good subset (of size 1 or 2) is found
    free(first_occurrence); // Free dynamically allocated memory
    *returnSize = 0;
    return NULL;
}