#include <stdlib.h>

int** matrixBlockSum(int** mat, int matSize, int* matColSize, int k, int* returnSize, int** returnColumnSizes) {
    int m = matSize;
    int n = *matColSize;

    int** prefixSum = (int**)malloc((m + 1) * sizeof(int*));
    for (int i = 0; i <= m; i++) {
        prefixSum[i] = (int*)calloc((n + 1), sizeof(int));
    }

    for (int r = 0; r < m; r++) {
        for (int c = 0; c < n; c++) {
            prefixSum[r + 1][c + 1] = mat[r][c] + prefixSum[r][c + 1] + prefixSum[r + 1][c] - prefixSum[r][c];
        }
    }

    int** answer = (int**)malloc(m * sizeof(int*));
    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        answer[i] = (int*)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = n;
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            int r1 = (i - k > 0) ? (i - k) : 0;
            int c1 = (j - k > 0) ? (j - k) : 0;
            int r2 = (i + k < m - 1) ? (i + k) : (m - 1);
            int c2 = (j + k < n - 1) ? (j + k) : (n - 1);

            answer[i][j] = prefixSum[r2 + 1][c2 + 1] - prefixSum[r1][c2 + 1] - prefixSum[r2 + 1][c1] + prefixSum[r1][c1];
        }
    }

    for (int i = 0; i <= m; i++) {
        free(prefixSum[i]);
    }
    free(prefixSum);

    return answer;
}