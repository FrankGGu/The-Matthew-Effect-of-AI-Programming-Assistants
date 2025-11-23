#include <stdlib.h>
#include <string.h> // Not strictly necessary if using calloc and not memset for initialization

static inline int max(int a, int b) {
    return a > b ? a : b;
}

static int dr[] = {0, 1, 0, -1};
static int dc[] = {1, 0, -1, 0};

static int** memo;
static int R_dim, C_dim;

int dfs(int r, int c, int** matrix) {
    // If the result for this cell is already computed, return it
    if (memo[r][c] != 0) {
        return memo[r][c];
    }

    // The current cell itself contributes 1 to the path length
    int max_len = 1;

    // Explore all four possible directions
    for (int i = 0; i < 4; i++) {
        int nr = r + dr[i];
        int nc = c + dc[i];

        // Check bounds and the increasing path condition
        if (nr >= 0 && nr < R_dim && nc >= 0 && nc < C_dim && matrix[nr][nc] > matrix[r][c]) {
            max_len = max(max_len, 1 + dfs(nr, nc, matrix));
        }
    }

    // Store the computed maximum path length starting from (r, c)
    memo[r][c] = max_len;
    return max_len;
}

int longestIncreasingPath(int** matrix, int matrixSize, int* matrixColSize) {
    R_dim = matrixSize;
    if (R_dim == 0) {
        return 0;
    }
    C_dim = matrixColSize[0];
    if (C_dim == 0) {
        return 0;
    }

    // Allocate and initialize the memoization table with zeros
    memo = (int**)malloc(R_dim * sizeof(int*));
    for (int i = 0; i < R_dim; i++) {
        memo[i] = (int*)calloc(C_dim, sizeof(int)); // calloc initializes to 0
    }

    int overall_max_path = 0;

    // Iterate through each cell in the matrix
    // Each cell can be the starting point of the longest increasing path
    for (int i = 0; i < R_dim; i++) {
        for (int j = 0; j < C_dim; j++) {
            overall_max_path = max(overall_max_path, dfs(i, j, matrix));
        }
    }

    // Free the dynamically allocated memoization table
    for (int i = 0; i < R_dim; i++) {
        free(memo[i]);
    }
    free(memo);

    return overall_max_path;
}