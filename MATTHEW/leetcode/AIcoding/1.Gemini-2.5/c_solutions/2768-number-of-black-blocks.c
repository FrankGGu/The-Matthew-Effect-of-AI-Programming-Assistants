#include <stdlib.h>
#include <string.h>

int compareLongLong(const void *a, const void *b) {
    long long valA = *(long long*)a;
    long long valB = *(long long*)b;
    if (valA < valB) return -1;
    if (valA > valB) return 1;
    return 0;
}

long long* findLongLong(long long key, long long* arr, int size) {
    return (long long*)bsearch(&key, arr, size, sizeof(long long), compareLongLong);
}

long long* numberOfBlackBlocks(int m, int n, int** coordinates, int coordinatesSize, int* coordinatesColSize, long long* returnSize) {
    *returnSize = 5;
    long long* ans = (long long*)calloc(5, sizeof(long long));
    if (ans == NULL) {
        return NULL; // Allocation failed
    }

    // Edge case: if no 2x2 blocks can be formed (grid is too small)
    if (m < 2 || n < 2) {
        // All elements of ans are already 0 from calloc, which is correct.
        // There are 0 total 2x2 blocks, so 0 blocks with 0 black cells, and 0 for others.
        return ans;
    }

    // Flatten black cell coordinates into a long long array for efficient lookup
    // Each coordinate (r, c) is flattened to r * n + c
    long long* black_cells_flat_arr = (long long*)malloc(coordinatesSize * sizeof(long long));
    if (black_cells_flat_arr == NULL) {
        free(ans);
        return NULL; // Allocation failed
    }

    for (int i = 0; i < coordinatesSize; ++i) {
        black_cells_flat_arr[i] = (long long)coordinates[i][0] * n + coordinates[i][1];
    }

    // Sort the flattened black cell coordinates and remove duplicates
    qsort(black_cells_flat_arr, coordinatesSize, sizeof(long long), compareLongLong);

    int unique_black_cells_count = 0;
    if (coordinatesSize > 0) {
        unique_black_cells_count = 1;
        for (int i = 1; i < coordinatesSize; ++i) {
            if (black_cells_flat_arr[i] != black_cells_flat_arr[i-1]) {
                black_cells_flat_arr[unique_black_cells_count++] = black_cells_flat_arr[i];
            }
        }
    }

    // Store potential 2x2 block top-left coordinates (flattened)
    // A single black cell can be part of up to 4 different 2x2 blocks.
    // So, max 4 * unique_black_cells_count blocks.
    long long* potential_blocks_flat_arr = (long long*)malloc(4 * unique_black_cells_count * sizeof(long long));
    if (potential_blocks_flat_arr == NULL) {
        free(ans);
        free(black_cells_flat_arr);
        return NULL; // Allocation failed
    }
    int potential_blocks_count = 0;

    // For each unique black cell, identify the 2x2 blocks it could belong to
    for (int i = 0; i < unique_black_cells_count; ++i) {
        long long flat_coord = black_cells_flat_arr[i];
        long long r = flat_coord / n;
        long long c = flat_coord % n;

        // A black cell (r, c) can be one of the four corners of a 2x2 block.
        // We determine the top-left corner (br, bc) of such a block.

        // 1. (r, c) is the top-left corner of the block: (br, bc) = (r, c)
        if (r < m - 1 && c < n - 1) {
            potential_blocks_flat_arr[potential_blocks_count++] = r * n + c;
        }
        // 2. (r, c) is the top-right corner: (br, bc) = (r, c-1)
        if (r < m - 1 && c > 0 && c - 1 < n - 1) {
            potential_blocks_flat_arr[potential_blocks_count++] = r * n + (c - 1);
        }
        // 3. (r, c) is the bottom-left corner: (br, bc) = (r-1, c)
        if (r > 0 && r - 1 < m - 1 && c < n - 1) {
            potential_blocks_flat_arr[potential_blocks_count++] = (r - 1) * n + c;
        }
        // 4. (r, c) is the bottom-right corner: (br, bc) = (r-1, c-1)
        if (r > 0 && r - 1 < m - 1 && c > 0 && c - 1 < n - 1) {
            potential_blocks_flat_arr[potential_blocks_count++] = (r - 1) * n + (c - 1);
        }
    }

    // Sort the potential block top-left coordinates and remove duplicates
    qsort(potential_blocks_flat_arr, potential_blocks_count, sizeof(long long), compareLongLong);

    int unique_potential_blocks_count = 0;
    if (potential_blocks_count > 0) {
        unique_potential_blocks_count = 1;
        for (int i = 1; i < potential_blocks_count; ++i) {
            if (potential_blocks_flat_arr[i] != potential_blocks_flat_arr[i-1]) {
                potential_blocks_flat_arr[unique_potential_blocks_count++] = potential_blocks_flat_arr[i];
            }
        }
    }

    // Iterate through each unique 2x2 block identified and count its black cells
    for (int i = 0; i < unique_potential_blocks_count; ++i) {
        long long block_flat = potential_blocks_flat_arr[i];
        long long br = block_flat / n; // Row of top-left corner
        long long bc = block_flat % n; // Column of top-left corner

        int black_cell_count = 0;
        // Check the four cells of the 2x2 block
        // (br, bc)
        if (findLongLong(br * n + bc, black_cells_flat_arr, unique_black_cells_count) != NULL) {
            black_cell_count++;
        }
        // (br, bc+1)
        if (findLongLong(br * n + (bc + 1), black_cells_flat_arr, unique_black_cells_count) != NULL) {
            black_cell_count++;
        }
        // (br+1, bc)
        if (findLongLong((br + 1) * n + bc, black_cells_flat_arr, unique_black_cells_count) != NULL) {
            black_cell_count++;
        }
        // (br+1, bc+1)
        if (findLongLong((br + 1) * n + (bc + 1), black_cells_flat_arr, unique_black_cells_count) != NULL) {
            black_cell_count++;
        }
        ans[black_cell_count]++;
    }

    // Calculate ans[0]: number of 2x2 blocks with zero black cells
    long long total_2x2_blocks = (long long)(m - 1) * (n - 1);
    long long blocks_with_black_cells = 0;
    for (int i = 1; i <= 4; ++i) {
        blocks_with_black_cells += ans[i];
    }
    ans[0] = total_2x2_blocks - blocks_with_black_cells;

    // Free dynamically allocated memory
    free(black_cells_flat_arr);
    free(potential_blocks_flat_arr);

    return ans;
}