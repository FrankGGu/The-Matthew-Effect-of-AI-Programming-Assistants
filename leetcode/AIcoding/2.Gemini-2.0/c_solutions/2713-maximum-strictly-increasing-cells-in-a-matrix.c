#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxIncreasingCells(int** mat, int matSize, int* matColSize) {
    int n = matSize, m = matColSize[0];
    int rowMax[n], colMax[m];
    for (int i = 0; i < n; i++) rowMax[i] = 0;
    for (int j = 0; j < m; j++) colMax[j] = 0;

    int* nums = (int*)malloc(n * m * sizeof(int));
    int numsSize = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            nums[numsSize++] = mat[i][j];
        }
    }

    int* sortedNums = (int*)malloc(n * m * sizeof(int));
    for (int i = 0; i < n * m; i++) sortedNums[i] = nums[i];

    qsort(sortedNums, n * m, sizeof(int), [](const void* a, const void* b) {
        return *(int*)a - *(int*)b;
    });

    int* uniqueNums = (int*)malloc(n * m * sizeof(int));
    int uniqueSize = 0;
    for (int i = 0; i < n * m; i++) {
        if (i == 0 || sortedNums[i] != sortedNums[i - 1]) {
            uniqueNums[uniqueSize++] = sortedNums[i];
        }
    }

    int** dp = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dp[i] = (int*)malloc(m * sizeof(int));
        for (int j = 0; j < m; j++) {
            dp[i][j] = 0;
        }
    }

    for (int k = 0; k < uniqueSize; k++) {
        int num = uniqueNums[k];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (mat[i][j] == num) {
                    dp[i][j] = 1 + (rowMax[i] > colMax[j] ? rowMax[i] : colMax[j]);
                }
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (mat[i][j] == num) {
                    rowMax[i] = (rowMax[i] > dp[i][j] ? rowMax[i] : dp[i][j]);
                    colMax[j] = (colMax[j] > dp[i][j] ? colMax[j] : dp[i][j]);
                }
            }
        }
    }

    int ans = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            ans = (ans > dp[i][j] ? ans : dp[i][j]);
        }
    }

    free(nums);
    free(sortedNums);
    free(uniqueNums);
    for (int i = 0; i < n; i++) free(dp[i]);
    free(dp);

    return ans;
}