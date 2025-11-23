#include <stdlib.h> // Required for malloc and calloc

int** rangeAddQueries(int n, int** queries, int queriesSize, int* queriesColSize, int* returnSize, int** returnColumnSizes) {
    int** ans = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        ans[i] = (int*)calloc(n, sizeof(int)); // calloc initializes to zero
    }

    for (int k = 0; k < queriesSize; k++) {
        int r1 = queries[k][0];
        int c1 = queries[k][1];
        int r2 = queries[k][2];
        int c2 = queries[k][3];

        ans[r1][c1]++;
        if (c2 + 1 < n) {
            ans[r1][c2 + 1]--;
        }
        if (r2 + 1 < n) {
            ans[r2 + 1][c1]--;
        }
        if (r2 + 1 < n && c2 + 1 < n) {
            ans[r2 + 1][c2 + 1]++;
        }
    }

    // Perform row-wise prefix sums
    for (int i = 0; i < n; i++) {
        for (int j = 1; j < n; j++) {
            ans[i][j] += ans[i][j - 1];
        }
    }

    // Perform column-wise prefix sums
    for (int j = 0; j < n; j++) {
        for (int i = 1; i < n; i++) {
            ans[i][j] += ans[i - 1][j];
        }
    }

    *returnSize = n;
    *returnColumnSizes = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        (*returnColumnSizes)[i] = n;
    }

    return ans;
}