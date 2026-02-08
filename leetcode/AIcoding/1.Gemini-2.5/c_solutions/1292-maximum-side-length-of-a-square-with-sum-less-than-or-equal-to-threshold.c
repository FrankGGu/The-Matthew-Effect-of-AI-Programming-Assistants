#include <stdbool.h>
#include <stdlib.h>

int min(int a, int b) {
    return a < b ? a : b;
}

bool check(int k, int rows, int cols, int** P, int threshold) {
    if (k == 0) return true;

    for (int r = 0; r <= rows - k; ++r) {
        for (int c = 0; c <= cols - k; ++c) {
            int current_sum = P[r + k][c + k] - P[r][c + k] - P[r + k][c] + P[r][c];
            if (current_sum <= threshold) {
                return true;
            }
        }
    }
    return false;
}

int maxSideLength(int** mat, int matSize, int* matColSize, int threshold) {
    int rows = matSize;
    if (rows == 0) return 0;
    int cols = matColSize[0];
    if (cols == 0) return 0;

    int** P = (int**)malloc((rows + 1) * sizeof(int*));
    for (int i = 0; i <= rows; ++i) {
        P[i] = (int*)malloc((cols + 1) * sizeof(int));
        for (int j = 0; j <= cols; ++j) {
            P[i][j] = 0;
        }
    }

    for (int i = 1; i <= rows; ++i) {
        for (int j = 1; j <= cols; ++j) {
            P[i][j] = mat[i-1][j-1] + P[i-1][j] + P[i][j-1] - P[i-1][j-1];
        }
    }

    int low = 0;
    int high = min(rows, cols);
    int ans = 0;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (check(mid, rows, cols, P, threshold)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    for (int i = 0; i <= rows; ++i) {
        free(P[i]);
    }
    free(P);

    return ans;
}