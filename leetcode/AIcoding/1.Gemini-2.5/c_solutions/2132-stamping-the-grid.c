#include <stdbool.h>
#include <stdlib.h>

static int queryZeros(int r1, int c1, int r2, int c2, int** prefixSumZeros) {
    return prefixSumZeros[r2+1][c2+1] - prefixSumZeros[r1][c2+1] - prefixSumZeros[r2+1][c1] + prefixSumZeros[r1][c1];
}

bool isPrintable(int** grid, int gridSize, int* gridColSize, int stampHeight, int stampWidth) {
    int m = gridSize;
    int n = gridColSize[0];

    int** prefixSumZeros = (int**)malloc((m + 1) * sizeof(int*));
    for (int i = 0; i <= m; i++) {
        prefixSumZeros[i] = (int*)calloc(n + 1, sizeof(int));
    }

    for (int r = 0; r < m; r++) {
        for (int c = 0; c < n; c++) {
            prefixSumZeros[r+1][c+1] = (grid[r][c] == 0);
            prefixSumZeros[r+1][c+1] += prefixSumZeros[r][c+1];
            prefixSumZeros[r+1][c+1] += prefixSumZeros[r+1][c];
            prefixSumZeros[r+1][c+1] -= prefixSumZeros[r][c];
        }
    }

    bool** canPlaceStamp = (bool**)malloc(m * sizeof(bool*));
    for (int i = 0; i < m; i++) {
        canPlaceStamp[i] = (bool*)calloc(n, sizeof(bool));
    }

    for (int r = 0; r <= m - stampHeight; r++) {
        for (int c = 0; c <= n - stampWidth; c++) {
            int zerosInRect = queryZeros(r, c, r + stampHeight - 1, c + stampWidth - 1, prefixSumZeros);
            if (zerosInRect == 0) {
                canPlaceStamp[r][c] = true;
            }
        }
    }

    int** diff = (int**)malloc((m + 1) * sizeof(int*));
    for (int i = 0; i <= m; i++) {
        diff[i] = (int*)calloc(n + 1, sizeof(int));
    }

    for (int r = 0; r < m; r++) {
        for (int c = 0; c < n; c++) {
            if (canPlaceStamp[r][c]) {
                diff[r][c]++;
                if (r + stampHeight < m) diff[r + stampHeight][c]--;
                if (c + stampWidth < n) diff[r][c + stampWidth]--;
                if (r + stampHeight < m && c + stampWidth < n) diff[r + stampHeight][c + stampWidth]++;
            }
        }
    }

    int** coveredCount = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        coveredCount[i] = (int*)calloc(n, sizeof(int));
    }

    for (int r = 0; r < m; r++) {
        for (int c = 0; c < n; c++) {
            coveredCount[r][c] = diff[r][c];
            if (r > 0) coveredCount[r][c] += coveredCount[r-1][c];
            if (c > 0) coveredCount[r][c] += coveredCount[r][c-1];
            if (r > 0 && c > 0) coveredCount[r][c] -= coveredCount[r-1][c-1];
        }
    }

    for (int r = 0; r < m; r++) {
        for (int c = 0; c < n; c++) {
            if (grid[r][c] == 1 && coveredCount[r][c] == 0) {
                for (int i = 0; i <= m; i++) free(prefixSumZeros[i]);
                free(prefixSumZeros);
                for (int i = 0; i < m; i++) free(canPlaceStamp[i]);
                free(canPlaceStamp);
                for (int i = 0; i <= m; i++) free(diff[i]);
                free(diff);
                for (int i = 0; i < m; i++) free(coveredCount[i]);
                free(coveredCount);
                return false;
            }
        }
    }

    for (int i = 0; i <= m; i++) free(prefixSumZeros[i]);
    free(prefixSumZeros);
    for (int i = 0; i < m; i++) free(canPlaceStamp[i]);
    free(canPlaceStamp);
    for (int i = 0; i <= m; i++) free(diff[i]);
    free(diff);
    for (int i = 0; i < m; i++) free(coveredCount[i]);
    free(coveredCount);

    return true;
}