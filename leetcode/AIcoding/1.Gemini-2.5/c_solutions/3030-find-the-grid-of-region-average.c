#include <stdlib.h> // For abs, malloc, calloc

int** findGridRegionAverage(int** grid, int gridSize, int* gridColSize, int threshold, int* returnSize, int** returnColumnSizes) {
    int m = gridSize;
    int n = gridColSize[0];

    int** result = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        result[i] = (int*)malloc(n * sizeof(int));
    }

    long long** sumGrid = (long long**)malloc(m * sizeof(long long*));
    int** countGrid = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        sumGrid[i] = (long long*)calloc(n, sizeof(long long));
        countGrid[i] = (int*)calloc(n, sizeof(int));
    }

    for (int r = 0; r <= m - 3; r++) {
        for (int c = 0; c <= n - 3; c++) {
            int isValidRegion = 1;

            for (int i = 0; i < 3; i++) {
                for (int j = 0; j < 2; j++) {
                    if (abs(grid[r + i][c + j] - grid[r + i][c + j + 1]) > threshold) {
                        isValidRegion = 0;
                        break;
                    }
                }
                if (!isValidRegion) break;
            }
            if (!isValidRegion) continue;

            for (int j = 0; j < 3; j++) {
                for (int i = 0; i < 2; i++) {
                    if (abs(grid[r + i][c + j] - grid[r + i + 1][c + j]) > threshold) {
                        isValidRegion = 0;
                        break;
                    }
                }
                if (!isValidRegion) break;
            }
            if (!isValidRegion) continue;

            long long currentRegionSum = 0;
            for (int i = 0; i < 3; i++) {
                for (int j = 0; j < 3; j++) {
                    currentRegionSum += grid[r + i][c + j];
                }
            }
            int regionAverage = currentRegionSum / 9;

            for (int i = 0; i < 3; i++) {
                for (int j = 0; j < 3; j++) {
                    sumGrid[r + i][c + j] += regionAverage;
                    countGrid[r + i][c + j]++;
                }
            }
        }
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (countGrid[i][j] > 0) {
                result[i][j] = sumGrid[i][j] / countGrid[i][j];
            } else {
                result[i][j] = grid[i][j];
            }
        }
    }

    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    for (int i = 0; i < m; i++) {
        free(sumGrid[i]);
        free(countGrid[i]);
    }
    free(sumGrid);
    free(countGrid);

    return result;
}