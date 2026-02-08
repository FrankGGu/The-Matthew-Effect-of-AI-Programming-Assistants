#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool possibleToStamp(int** grid, int gridSize, int* gridColSize, int stampHeight, int stampWidth) {
    int n = gridSize;
    int m = *gridColSize;

    int** prefixSum = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        prefixSum[i] = (int*)malloc((m + 1) * sizeof(int));
        for (int j = 0; j <= m; j++) {
            prefixSum[i][j] = 0;
        }
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            prefixSum[i][j] = prefixSum[i - 1][j] + prefixSum[i][j - 1] - prefixSum[i - 1][j - 1] + grid[i - 1][j - 1];
        }
    }

    int** canStamp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        canStamp[i] = (int*)malloc(m * sizeof(int));
        for (int j = 0; j < m; j++) {
            canStamp[i][j] = 0;
        }
    }

    for (int i = 0; i <= n - stampHeight; i++) {
        for (int j = 0; j <= m - stampWidth; j++) {
            int sum = prefixSum[i + stampHeight][j + stampWidth] - prefixSum[i + stampHeight][j] - prefixSum[i][j + stampWidth] + prefixSum[i][j];
            if (sum == 0) {
                canStamp[i][j] = 1;
            }
        }
    }

    int** stampPrefixSum = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        stampPrefixSum[i] = (int*)malloc((m + 1) * sizeof(int));
        for (int j = 0; j <= m; j++) {
            stampPrefixSum[i][j] = 0;
        }
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            stampPrefixSum[i][j] = stampPrefixSum[i - 1][j] + stampPrefixSum[i][j - 1] - stampPrefixSum[i - 1][j - 1] + canStamp[i - 1][j - 1];
        }
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if (grid[i][j] == 0) {
                int r1 = i - stampHeight + 1;
                int c1 = j - stampWidth + 1;
                int r2 = i;
                int c2 = j;

                r1 = (r1 < 0) ? 0 : r1;
                c1 = (c1 < 0) ? 0 : c1;

                int sum = stampPrefixSum[r2 + 1][c2 + 1] - stampPrefixSum[r2 + 1][c1] - stampPrefixSum[r1][c2 + 1] + stampPrefixSum[r1][c1];
                if (sum == 0) {
                    for (int k = 0; k <= n; k++) {
                        free(prefixSum[k]);
                        free(stampPrefixSum[k]);
                    }
                    for (int k = 0; k < n; k++) {
                        free(canStamp[k]);
                    }
                    free(prefixSum);
                    free(canStamp);
                    free(stampPrefixSum);

                    return false;
                }
            }
        }
    }

    for (int k = 0; k <= n; k++) {
        free(prefixSum[k]);
        free(stampPrefixSum[k]);
    }
    for (int k = 0; k < n; k++) {
        free(canStamp[k]);
    }
    free(prefixSum);
    free(canStamp);
    free(stampPrefixSum);

    return true;
}