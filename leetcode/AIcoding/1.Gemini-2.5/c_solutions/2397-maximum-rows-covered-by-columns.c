#include <stdbool.h>

int maximumRows(int** mat, int matSize, int* matColSize, int numSelect) {
    int m = matSize;
    int n = matColSize[0];

    int maxCoveredRows = 0;

    for (int mask = 0; mask < (1 << n); ++mask) {
        if (__builtin_popcount(mask) == numSelect) {
            int currentCoveredRows = 0;

            for (int i = 0; i < m; ++i) {
                bool isRowCovered = true;
                for (int j = 0; j < n; ++j) {
                    if (mat[i][j] == 1) {
                        if (!((mask >> j) & 1)) {
                            isRowCovered = false;
                            break;
                        }
                    }
                }
                if (isRowCovered) {
                    currentCoveredRows++;
                }
            }
            if (currentCoveredRows > maxCoveredRows) {
                maxCoveredRows = currentCoveredRows;
            }
        }
    }

    return maxCoveredRows;
}