#include <stdbool.h>

bool canPartition(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    int total_sum = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            total_sum += grid[i][j];
        }
    }

    if (total_sum % 2 != 0) {
        return false;
    }

    int target_sum = total_sum / 2;

    int current_rows_sum = 0;
    for (int r = 0; r < m - 1; r++) {
        for (int c = 0; c < n; c++) {
            current_rows_sum += grid[r][c];
        }
        if (current_rows_sum == target_sum) {
            return true;
        }
    }

    int current_cols_sum = 0;
    for (int c = 0; c < n - 1; c++) {
        for (int r = 0; r < m; r++) {
            current_cols_sum += grid[r][c];
        }
        if (current_cols_sum == target_sum) {
            return true;
        }
    }

    return false;
}