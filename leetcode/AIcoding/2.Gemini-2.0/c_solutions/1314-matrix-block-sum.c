#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** matrixBlockSum(int** mat, int matSize, int* matColSize, int K, int* returnSize, int** returnColumnSizes) {
    int n = matSize;
    int m = *matColSize;

    int** sum = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        sum[i] = (int*)malloc((m + 1) * sizeof(int));
        for (int j = 0; j <= m; j++) {
            sum[i][j] = 0;
        }
    }

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= m; j++) {
            sum[i][j] = sum[i - 1][j] + sum[i][j - 1] - sum[i - 1][j - 1] + mat[i - 1][j - 1];
        }
    }

    int** ans = (int**)malloc(n * sizeof(int*));
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        ans[i] = (int*)malloc(m * sizeof(int));
        (*returnColumnSizes)[i] = m;
        for (int j = 0; j < m; j++) {
            int r1 = (i - K >= 0) ? i - K : 0;
            int c1 = (j - K >= 0) ? j - K : 0;
            int r2 = (i + K < n) ? i + K : n - 1;
            int c2 = (j + K < m) ? j + K : m - 1;

            r1++;
            c1++;
            r2++;
            c2++;
            ans[i][j] = sum[r2][c2] - sum[r1 - 1][c2] - sum[r2][c1 - 1] + sum[r1 - 1][c1 - 1];
        }
    }

    *returnSize = n;

    for (int i = 0; i <= n; i++) {
        free(sum[i]);
    }
    free(sum);

    return ans;
}