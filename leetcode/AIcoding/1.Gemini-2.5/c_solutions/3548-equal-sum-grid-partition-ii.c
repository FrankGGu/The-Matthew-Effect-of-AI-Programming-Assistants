#include <stdbool.h>
#include <stdlib.h>

long long getSum(long long** ps, int r1, int c1, int r2, int c2) {
    return ps[r2 + 1][c2 + 1] - ps[r1][c2 + 1] - ps[r2 + 1][c1] + ps[r1][c1];
}

bool equalSumGridPartitionII(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    if (m == 0) return false;
    int n = gridColSize[0];
    if (n == 0) return false;

    if (m < 2 || n < 2) {
        return false;
    }

    long long** ps = (long long**)malloc((m + 1) * sizeof(long long*));
    for (int i = 0; i <= m; ++i) {
        ps[i] = (long long*)malloc((n + 1) * sizeof(long long));
        for (int j = 0; j <= n; ++j) {
            ps[i][j] = 0;
        }
    }

    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            ps[i + 1][j + 1] = (long long)grid[i][j] + ps[i][j + 1] + ps[i + 1][j] - ps[i][j];
        }
    }

    for (int r = 0; r < m - 1; ++r) {
        for (int c = 0; c < n - 1; ++c) {
            long long sum1 = getSum(ps, 0, 0, r, c);
            long long sum2 = getSum(ps, 0, c + 1, r, n - 1);
            long long sum3 = getSum(ps, r + 1, 0, m - 1, c);
            long long sum4 = getSum(ps, r + 1, c + 1, m - 1, n - 1);

            if (sum1 == sum2 && sum2 == sum3 && sum3 == sum4) {
                for (int i = 0; i <= m; ++i) {
                    free(ps[i]);
                }
                free(ps);
                return true;
            }
        }
    }

    for (int i = 0; i <= m; ++i) {
        free(ps[i]);
    }
    free(ps);

    return false;
}