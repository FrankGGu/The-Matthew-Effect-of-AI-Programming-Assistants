long long numberOfRightTriangles(int** grid, int gridSize, int* gridColSize) {
    int R = gridSize;
    int C = gridColSize[0];

    // left_prefix_sum[r][c] stores the count of stars in row r from column 0 to c-1.
    // This will be the 'count_left' for a star at (r, c).
    int** left_prefix_sum = (int**)malloc(R * sizeof(int*));
    for (int i = 0; i < R; i++) {
        left_prefix_sum[i] = (int*)malloc(C * sizeof(int));
    }

    // down_suffix_sum[r][c] stores the count of stars in column c from row r+1 to R-1.
    // This will be the 'count_down' for a star at (r, c).
    int** down_suffix_sum = (int**)malloc(R * sizeof(int*));
    for (int i = 0; i < R; i++) {
        down_suffix_sum[i] = (int*)malloc(C * sizeof(int));
    }

    // Calculate left_prefix_sum
    for (int r = 0; r < R; r++) {
        int current_row_stars = 0;
        for (int c = 0; c < C; c++) {
            left_prefix_sum[r][c] = current_row_stars;
            if (grid[r][c] == 1) {
                current_row_stars++;
            }
        }
    }

    // Calculate down_suffix_sum
    for (int c = 0; c < C; c++) {
        int current_col_stars = 0;
        for (int r = R - 1; r >= 0; r--) {
            down_suffix_sum[r][c] = current_col_stars;
            if (grid[r][c] == 1) {
                current_col_stars++;
            }
        }
    }

    long long total_triangles = 0;

    // Iterate through each cell (r, c)
    for (int r = 0; r < R; r++) {
        for (int c = 0; c < C; c++) {
            // If grid[r][c] is a star, it can be the 'top-right vertex' (P1)
            if (grid[r][c] == 1) {
                // Number of stars to its left in the same row (P2 candidates)
                long long count_left = left_prefix_sum[r][c];
                // Number of stars below it in the same column (P3 candidates)
                long long count_down = down_suffix_sum[r][c];

                total_triangles += count_left * count_down;
            }
        }
    }

    // Free allocated memory
    for (int i = 0; i < R; i++) {
        free(left_prefix_sum[i]);
        free(down_suffix_sum[i]);
    }
    free(left_prefix_sum);
    free(down_suffix_sum);

    return total_triangles;
}