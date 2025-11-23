#include <stdlib.h>

int** imageSmoother(int** img, int imgSize, int* imgColSize, int* returnSize, int** returnColumnSizes) {
    int m = imgSize;
    int n = imgColSize[0];

    int** result = (int**)malloc(m * sizeof(int*));
    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));

    for (int i = 0; i < m; ++i) {
        result[i] = (int*)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = n;
    }

    for (int r = 0; r < m; ++r) {
        for (int c = 0; c < n; ++c) {
            int sum = 0;
            int count = 0;

            for (int nr = r - 1; nr <= r + 1; ++nr) {
                for (int nc = c - 1; nc <= c + 1; ++nc) {
                    if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                        sum += img[nr][nc];
                        count++;
                    }
                }
            }
            result[r][c] = sum / count;
        }
    }

    return result;
}