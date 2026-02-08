#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* getBiggestThree(int** grid, int gridSize, int* gridColSize, int* returnSize) {
    int m = gridSize;
    int n = gridColSize[0];
    int maxSums[3] = {0};
    bool seen[100001] = {false};

    int maxSumCount = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            for (int len = 0; i - len >= 0 && i + len < m && j - len >= 0 && j + len < n; len++) {
                int sum = grid[i][j];
                if (len > 0) {
                    for (int k = 1; k <= len; k++) {
                        sum += grid[i - k][j - len + k];
                        sum += grid[i - k][j + len - k];
                        sum += grid[i + k][j - len + k];
                        sum += grid[i + k][j + len - k];
                    }
                }

                if (!seen[sum + 50000]) {
                    seen[sum + 50000] = true;
                    if (maxSumCount < 3) {
                        maxSums[maxSumCount++] = sum;
                        for (int k = maxSumCount - 1; k > 0; k--) {
                            if (maxSums[k] > maxSums[k - 1]) {
                                int temp = maxSums[k];
                                maxSums[k] = maxSums[k - 1];
                                maxSums[k - 1] = temp;
                            }
                        }
                    } else {
                        if (sum > maxSums[2]) {
                            maxSums[2] = sum;
                            for (int k = 2; k > 0; k--) {
                                if (maxSums[k] > maxSums[k - 1]) {
                                    int temp = maxSums[k];
                                    maxSums[k] = maxSums[k - 1];
                                    maxSums[k - 1] = temp;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    int* result = (int*)malloc(sizeof(int) * maxSumCount);
    for (int i = 0; i < maxSumCount; i++) {
        result[i] = maxSums[i];
    }

    *returnSize = maxSumCount;
    return result;
}