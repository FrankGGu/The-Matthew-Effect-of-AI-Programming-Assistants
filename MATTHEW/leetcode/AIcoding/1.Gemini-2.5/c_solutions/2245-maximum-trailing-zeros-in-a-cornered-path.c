#include <stdlib.h> // For malloc, free

int get_factor_count(int n, int factor) {
    int count = 0;
    while (n > 0 && n % factor == 0) {
        count++;
        n /= factor;
    }
    return count;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int maximumTrailingZeros(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = gridColSize[0];

    // Step 1: Precompute factor counts (2s and 5s) for each cell
    int** count2 = (int**)malloc(rows * sizeof(int*));
    int** count5 = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        count2[i] = (int*)malloc(cols * sizeof(int));
        count5[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            count2[i][j] = get_factor_count(grid[i][j], 2);
            count5[i][j] = get_factor_count(grid[i][j], 5);
        }
    }

    // Step 2: Compute prefix/suffix sums for 2s and 5s in 4 directions
    // up[r][c]: sum of factors from (0, c) to (r, c)
    // down[r][c]: sum of factors from (r, c) to (rows-1, c)
    // left[r][c]: sum of factors from (r, 0) to (r, c)
    // right[r][c]: sum of factors from (r, c) to (r, cols-1)

    int** up2 = (int**)malloc(rows * sizeof(int*));
    int** up5 = (int**)malloc(rows * sizeof(int*));
    int** down2 = (int**)malloc(rows * sizeof(int*));
    int** down5 = (int**)malloc(rows * sizeof(int*));
    int** left2 = (int**)malloc(rows * sizeof(int*));
    int** left5 = (int**)malloc(rows * sizeof(int*));
    int** right2 = (int**)malloc(rows * sizeof(int*));
    int** right5 = (int**)malloc(rows * sizeof(int*));

    for (int i = 0; i < rows; i++) {
        up2[i] = (int*)malloc(cols * sizeof(int));
        up5[i] = (int*)malloc(cols * sizeof(int));
        down2[i] = (int*)malloc(cols * sizeof(int));
        down5[i] = (int*)malloc(cols * sizeof(int));
        left2[i] = (int*)malloc(cols * sizeof(int));
        left5[i] = (int*)malloc(cols * sizeof(int));
        right2[i] = (int*)malloc(cols * sizeof(int));
        right5[i] = (int*)malloc(cols * sizeof(int));
    }

    // Calculate up and left prefix sums
    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            up2[r][c] = count2[r][c] + (r > 0 ? up2[r-1][c] : 0);
            up5[r][c] = count5[r][c] + (r > 0 ? up5[r-1][c] : 0);
            left2[r][c] = count2[r][c] + (c > 0 ? left2[r][c-1] : 0);
            left5[r][c] = count5[r][c] + (c > 0 ? left5[r][c-1] : 0);
        }
    }

    // Calculate down and right suffix sums
    for (int r = rows - 1; r >= 0; r--) {
        for (int c = cols - 1; c >= 0; c--) {
            down2[r][c] = count2[r][c] + (r < rows - 1 ? down2[r+1][c] : 0);
            down5[r][c] = count5[r][c] + (r < rows - 1 ? down5[r+1][c] : 0);
            right2[r][c] = count2[r][c] + (c < cols - 1 ? right2[r][c+1] : 0);
            right5[r][c] = count5[r][c] + (c < cols - 1 ? right5[r][c+1] : 0);
        }
    }

    int max_zeros = 0;

    // Step 3: Iterate through each cell as a potential corner
    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            // Four types of cornered paths meeting at (r, c)
            // The corner cell (r, c) is included in both segments, so its factor counts are added once.
            // This is handled by summing the segment totals and subtracting count2/5[r][c] once.

            // 1. Up-Left path
            int total2 = up2[r][c] + left2[r][c] - count2[r][c];
            int total5 = up5[r][c] + left5[r][c] - count5[r][c];
            max_zeros = max(max_zeros, min(total2, total5));

            // 2. Up-Right path
            total2 = up2[r][c] + right2[r][c] - count2[r][c];
            total5 = up5[r][c] + right5[r][c] - count5[r][c];
            max_zeros = max(max_zeros, min(total2, total5));

            // 3. Down-Left path
            total2 = down2[r][c] + left2[r][c] - count2[r][c];
            total5 = down5[r][c] + left5[r][c] - count5[r][c];
            max_zeros = max(max_zeros, min(total2, total5));

            // 4. Down-Right path
            total2 = down2[r][c] + right2[r][c] - count2[r][c];
            total5 = down5[r][c] + right5[r][c] - count5[r][c];
            max_zeros = max(max_zeros, min(total2, total5));
        }
    }

    // Free allocated memory
    for (int i = 0; i < rows; i++) {
        free(count2[i]);
        free(count5[i]);
        free(up2[i]);
        free(up5[i]);
        free(down2[i]);
        free(down5[i]);
        free(left2[i]);
        free(left5[i]);
        free(right2[i]);
        free(right5[i]);
    }
    free(count2);
    free(count5);
    free(up2);
    free(up5);
    free(down2);
    free(down5);
    free(left2);
    free(left5);
    free(right2);
    free(right5);

    return max_zeros;
}