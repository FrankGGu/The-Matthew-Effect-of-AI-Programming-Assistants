#include <stdio.h>
#include <stdlib.h>

int* sumDistance(int* houses, int housesSize, int k, int* returnSize) {
    *returnSize = 0;
    if (housesSize == 0 || k == 0) return NULL;

    int* result = (int*)malloc(housesSize * sizeof(int));
    if (!result) return NULL;

    int* sortedHouses = (int*)malloc(housesSize * sizeof(int));
    for (int i = 0; i < housesSize; i++) {
        sortedHouses[i] = houses[i];
    }

    for (int i = 0; i < housesSize - 1; i++) {
        for (int j = 0; j < housesSize - i - 1; j++) {
            if (sortedHouses[j] > sortedHouses[j + 1]) {
                int temp = sortedHouses[j];
                sortedHouses[j] = sortedHouses[j + 1];
                sortedHouses[j + 1] = temp;
            }
        }
    }

    int** dp = (int**)malloc(housesSize * sizeof(int*));
    for (int i = 0; i < housesSize; i++) {
        dp[i] = (int*)malloc(housesSize * sizeof(int));
    }

    for (int i = 0; i < housesSize; i++) {
        for (int j = i; j < housesSize; j++) {
            dp[i][j] = 0;
            for (int m = i; m <= j; m++) {
                dp[i][j] += abs(sortedHouses[m] - sortedHouses[(i + j) / 2]);
            }
        }
    }

    int* f = (int*)malloc((k + 1) * sizeof(int));
    int* g = (int*)malloc((k + 1) * sizeof(int));

    for (int i = 0; i < housesSize; i++) {
        f[i] = dp[0][i];
    }

    for (int t = 1; t < k; t++) {
        for (int i = 0; i < housesSize; i++) {
            g[i] = INT_MAX;
            for (int j = t - 1; j < i; j++) {
                if (g[i] > f[j] + dp[j + 1][i]) {
                    g[i] = f[j] + dp[j + 1][i];
                }
            }
        }
        for (int i = 0; i < housesSize; i++) {
            f[i] = g[i];
        }
    }

    *returnSize = housesSize;
    for (int i = 0; i < housesSize; i++) {
        result[i] = f[i];
    }

    for (int i = 0; i < housesSize; i++) {
        free(dp[i]);
    }
    free(dp);
    free(f);
    free(g);
    free(sortedHouses);

    return result;
}