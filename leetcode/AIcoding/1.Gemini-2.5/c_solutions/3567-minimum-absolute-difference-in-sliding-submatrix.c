#include <limits.h>

int minimumAbsoluteDifference(int** grid, int gridSize, int* gridColSize, int k) {
    int m = gridSize;
    int n = gridColSize[0];

    int min_abs_diff = INT_MAX;

    int current_freq[101];

    for (int r = 0; r <= m - k; ++r) {
        for (int i = 0; i < 101; ++i) {
            current_freq[i] = 0;
        }

        for (int i = r; i < r + k; ++i) {
            for (int j = 0; j < k; ++j) {
                current_freq[grid[i][j]]++;
            }
        }

        int prev_val = -1;
        for (int val = 1; val <= 100; ++val) {
            if (current_freq[val] > 0) {
                if (current_freq[val] > 1) {
                    min_abs_diff = 0;
                    goto end_loops;
                }
                if (prev_val != -1) {
                    if (val - prev_val < min_abs_diff) {
                        min_abs_diff = val - prev_val;
                    }
                }
                prev_val = val;
            }
        }

        for (int c = 1; c <= n - k; ++c) {
            for (int i = r; i < r + k; ++i) {
                current_freq[grid[i][c - 1]]--;
            }
            for (int i = r; i < r + k; ++i) {
                current_freq[grid[i][c + k - 1]]++;
            }

            prev_val = -1;
            for (int val = 1; val <= 100; ++val) {
                if (current_freq[val] > 0) {
                    if (current_freq[val] > 1) {
                        min_abs_diff = 0;
                        goto end_loops;
                    }
                    if (prev_val != -1) {
                        if (val - prev_val < min_abs_diff) {
                            min_abs_diff = val - prev_val;
                        }
                    }
                    prev_val = val;
                }
            }
        }
    }

end_loops:;

    return min_abs_diff;
}