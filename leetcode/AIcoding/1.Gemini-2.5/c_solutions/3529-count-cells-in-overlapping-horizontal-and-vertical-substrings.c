#include <stdlib.h>
#include <stdbool.h>

int countCells(char** grid, int gridSize, int* gridColSize) {
    if (gridSize == 0 || gridColSize[0] == 0) {
        return 0;
    }

    int M = gridSize;
    int N = gridColSize[0];

    bool** is_h = (bool**)calloc(M, sizeof(bool*));
    for (int i = 0; i < M; i++) {
        is_h[i] = (bool*)calloc(N, sizeof(bool));
    }

    for (int r = 0; r < M; r++) {
        int current_len = 1;
        for (int c = 1; c < N; c++) {
            if (grid[r][c] == grid[r][c-1]) {
                current_len++;
            } else {
                if (current_len >= 2) {
                    for (int k = c - current_len; k < c; k++) {
                        is_h[r][k] = true;
                    }
                }
                current_len = 1;
            }
        }
        if (current_len >= 2) {
            for (int k = N - current_len; k < N; k++) {
                is_h[r][k] = true;
            }
        }
    }

    bool** is_v = (bool**)calloc(M, sizeof(bool*));
    for (int i = 0; i < M; i++) {
        is_v[i] = (bool*)calloc(N, sizeof(bool));
    }

    for (int c = 0; c < N; c++) {
        int current_len = 1;
        for (int r = 1; r < M; r++) {
            if (grid[r][c] == grid[r-1][c]) {
                current_len++;
            } else {
                if (current_len >= 2) {
                    for (int k = r - current_len; k < r; k++) {
                        is_v[k][c] = true;
                    }
                }
                current_len = 1;
            }
        }
        if (current_len >= 2) {
            for (int k = M - current_len; k < M; k++) {
                is_v[k][c] = true;
            }
        }
    }

    int count = 0;
    for (int r = 0; r < M; r++) {
        for (int c = 0; c < N; c++) {
            if (is_h[r][c] && is_v[r][c]) {
                count++;
            }
        }
    }

    for (int i = 0; i < M; i++) {
        free(is_h[i]);
        free(is_v[i]);
    }
    free(is_h);
    free(is_v);

    return count;
}