#include <stdio.h>
#include <stdlib.h>

int** matrixBlockSum(int** mat, int matSize, int* matColSize, int K, int* returnSize, int** returnColumnSizes) {
    int n = matSize;
    int m = matColSize[0];
    int** prefix = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        prefix[i] = (int*)calloc(m, sizeof(int));
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            int top = (i - 1 >= 0) ? prefix[i - 1][j] : 0;
            int left = (j - 1 >= 0) ? prefix[i][j - 1] : 0;
            int diagonal = (i - 1 >= 0 && j - 1 >= 0) ? prefix[i - 1][j - 1] : 0;
            prefix[i][j] = mat[i][j] + top + left - diagonal;
        }
    }

    int** result = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        result[i] = (int*)calloc(m, sizeof(int));
    }

    *returnSize = n;
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        (*returnColumnSizes)[i] = m;
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            int r1 = i - K;
            int c1 = j - K;
            int r2 = i + K;
            int c2 = j + K;

            r1 = (r1 < 0) ? 0 : r1;
            c1 = (c1 < 0) ? 0 : c1;
            r2 = (r2 >= n) ? n - 1 : r2;
            c2 = (c2 >= m) ? m - 1 : c2;

            int total = prefix[r2][c2];
            int top = (r1 - 1 >= 0) ? prefix[r1 - 1][c2] : 0;
            int left = (c1 - 1 >= 0) ? prefix[r2][c1 - 1] : 0;
            int diagonal = (r1 - 1 >= 0 && c1 - 1 >= 0) ? prefix[r1 - 1][c1 - 1] : 0;

            result[i][j] = total - top - left + diagonal;
        }
    }

    return result;
}