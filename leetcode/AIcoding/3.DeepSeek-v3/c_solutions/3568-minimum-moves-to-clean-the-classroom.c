#include <stdlib.h>
#include <string.h>

int minMoves(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize, n = gridColSize[0];
    int dirty = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) dirty++;
        }
    }

    if (dirty == 0) return 0;

    int* rows = (int*)calloc(m, sizeof(int));
    int* cols = (int*)calloc(n, sizeof(int));
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 1) {
                rows[i]++;
                cols[j]++;
            }
        }
    }

    int maxRow = 0, maxCol = 0;
    for (int i = 0; i < m; i++) {
        if (rows[i] > rows[maxRow]) maxRow = i;
    }
    for (int j = 0; j < n; j++) {
        if (cols[j] > cols[maxCol]) maxCol = j;
    }

    int res = 0;
    if (rows[maxRow] >= cols[maxCol]) {
        res++;
        for (int j = 0; j < n; j++) {
            if (grid[maxRow][j] == 1) {
                grid[maxRow][j] = 0;
                dirty--;
                cols[j]--;
            }
        }
        rows[maxRow] = 0;
    } else {
        res++;
        for (int i = 0; i < m; i++) {
            if (grid[i][maxCol] == 1) {
                grid[i][maxCol] = 0;
                dirty--;
                rows[i]--;
            }
        }
        cols[maxCol] = 0;
    }

    free(rows);
    free(cols);

    return res + minMoves(grid, m, gridColSize);
}