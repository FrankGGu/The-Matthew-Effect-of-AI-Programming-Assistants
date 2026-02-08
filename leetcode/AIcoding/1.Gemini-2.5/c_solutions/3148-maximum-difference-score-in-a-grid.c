#include <limits.h>
#include <stdlib.h>

static inline int min(int a, int b) {
    return a < b ? a : b;
}

static inline int max(int a, int b) {
    return a > b ? a : b;
}

int maxDifferenceScore(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    int** min_so_far = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        min_so_far[i] = (int*)malloc(n * sizeof(int));
    }

    int max_score = INT_MIN;

    for (int r = 0; r < m; r++) {
        for (int c = 0; c < n; c++) {
            int min_val_from_valid_prefix = INT_MAX;

            if (r > 0) {
                min_val_from_valid_prefix = min(min_val_from_valid_prefix, min_so_far[r-1][c]);
            }
            if (c > 0) {
                min_val_from_valid_prefix = min(min_val_from_valid_prefix, min_so_far[r][c-1]);
            }

            if (min_val_from_valid_prefix != INT_MAX) {
                max_score = max(max_score, grid[r][c] - min_val_from_valid_prefix);
            }

            int current_min_for_dp_update = grid[r][c];
            if (r > 0) {
                current_min_for_dp_update = min(current_min_for_dp_update, min_so_far[r-1][c]);
            }
            if (c > 0) {
                current_min_for_dp_update = min(current_min_for_dp_update, min_so_far[r][c-1]);
            }
            min_so_far[r][c] = current_min_for_dp_update;
        }
    }

    for (int i = 0; i < m; i++) {
        free(min_so_far[i]);
    }
    free(min_so_far);

    return max_score;
}