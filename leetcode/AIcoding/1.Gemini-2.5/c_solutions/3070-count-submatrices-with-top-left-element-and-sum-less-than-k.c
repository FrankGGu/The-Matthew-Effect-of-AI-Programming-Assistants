#include <stdlib.h>

int countSubmatrices(int** grid, int gridSize, int* gridColSize, int k) {
    int rows = gridSize;
    int cols = gridColSize[0];

    int** ps = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        ps[i] = (int*)malloc(cols * sizeof(int));
    }

    int count = 0;

    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            ps[r][c] = grid[r][c];

            if (r > 0) {
                ps[r][c] += ps[r-1][c];
            }
            if (c > 0) {
                ps[r][c] += ps[r][c-1];
            }
            if (r > 0 && c > 0) {
                ps[r][c] -= ps[r-1][c-1];
            }

            if (ps[r][c] <= k) {
                count++;
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        free(ps[i]);
    }
    free(ps);

    return count;
}