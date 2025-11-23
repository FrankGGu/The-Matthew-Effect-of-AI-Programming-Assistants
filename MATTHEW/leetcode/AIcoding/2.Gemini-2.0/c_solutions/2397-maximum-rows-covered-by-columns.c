#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int max(int a, int b) {
    return (a > b) ? a : b;
}

int maximumRows(int** matrix, int matrixSize, int* matrixColSize, int numSelect) {
    int m = matrixSize;
    int n = *matrixColSize;
    int ans = 0;

    for (int i = 0; i < (1 << n); i++) {
        if (__builtin_popcount(i) != numSelect) continue;

        int covered = 0;
        for (int row = 0; row < m; row++) {
            int all_covered = 1;
            for (int col = 0; col < n; col++) {
                if (matrix[row][col] == 1 && !(i & (1 << col))) {
                    all_covered = 0;
                    break;
                }
            }
            if (all_covered) covered++;
        }
        ans = max(ans, covered);
    }

    return ans;
}