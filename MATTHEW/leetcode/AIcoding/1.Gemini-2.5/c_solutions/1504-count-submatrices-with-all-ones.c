#include <stdlib.h>

int numSubmatrices(int** mat, int matSize, int* matColSize) {
    if (matSize == 0 || matColSize[0] == 0) {
        return 0;
    }

    int m = matSize;
    int n = matColSize[0];
    int count = 0;

    int* heights = (int*)malloc(n * sizeof(int));
    if (heights == NULL) {
        return 0;
    }
    for (int j = 0; j < n; ++j) {
        heights[j] = 0;
    }

    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            if (mat[i][j] == 1) {
                heights[j]++;
            } else {
                heights[j] = 0;
            }
        }

        for (int j = 0; j < n; ++j) {
            if (heights[j] > 0) {
                int min_h = heights[j];
                for (int k = j; k >= 0; --k) {
                    if (heights[k] == 0) {
                        break;
                    }
                    min_h = (min_h < heights[k]) ? min_h : heights[k];
                    count += min_h;
                }
            }
        }
    }

    free(heights);
    return count;
}