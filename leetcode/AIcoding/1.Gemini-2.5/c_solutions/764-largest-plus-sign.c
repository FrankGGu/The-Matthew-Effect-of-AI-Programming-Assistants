#include <stdlib.h> // For malloc, free
#include <string.h> // For memset

int min(int a, int b) {
    return a < b ? a : b;
}

int largestPlusSign(int n, int** mines, int minesSize, int* minesColSize) {
    int** grid = (int**)malloc(n * sizeof(int*));
    int** dp = (int**)malloc(n * sizeof(int*));

    for (int i = 0; i < n; i++) {
        grid[i] = (int*)malloc(n * sizeof(int));
        dp[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            grid[i][j] = 1; // All cells are initially empty
            dp[i][j] = n;   // Initialize dp with n (maximum possible order)
        }
    }

    // Mark mines and set their dp value to 0
    for (int i = 0; i < minesSize; i++) {
        int r = mines[i][0];
        int c = mines[i][1];
        grid[r][c] = 0;
        dp[r][c] = 0; // Mines cannot be part of any plus sign, so their order is 0
    }

    // Pass 1: Calculate consecutive empty cells to the left
    for (int r = 0; r < n; r++) {
        int count = 0;
        for (int c = 0; c < n; c++) {
            if (grid[r][c] == 1) {
                count++;
            } else {
                count = 0;
            }
            dp[r][c] = min(dp[r][c], count);
        }
    }

    // Pass 2: Calculate consecutive empty cells to the right
    for (int r = 0; r < n; r++) {
        int count = 0;
        for (int c = n - 1; c >= 0; c--) {
            if (grid[r][c] == 1) {
                count++;
            } else {
                count = 0;
            }
            dp[r][c] = min(dp[r][c], count);
        }
    }

    // Pass 3: Calculate consecutive empty cells upwards
    for (int c = 0; c < n; c++) {
        int count = 0;
        for (int r = 0; r < n; r++) {
            if (grid[r][c] == 1) {
                count++;
            } else {
                count = 0;
            }
            dp[r][c] = min(dp[r][c], count);
        }
    }

    // Pass 4: Calculate consecutive empty cells downwards
    for (int c = 0; c < n; c++) {
        int count = 0;
        for (int r = n - 1; r >= 0; r--) {
            if (grid[r][c] == 1) {
                count++;
            } else {
                count = 0;
            }
            dp[r][c] = min(dp[r][c], count);
        }
    }

    // Find the maximum order from the dp table
    int max_order = 0;
    for (int r = 0; r < n; r++) {
        for (int c = 0; c < n; c++) {
            if (dp[r][c] > max_order) {
                max_order = dp[r][c];
            }
        }
    }

    // Free dynamically allocated memory
    for (int i = 0; i < n; i++) {
        free(grid[i]);
        free(dp[i]);
    }
    free(grid);
    free(dp);

    return max_order;
}