/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** updateMatrix(int** mat, int matSize, int* matColSize, int* returnSize, int** returnColumnSizes) {
    int m = matSize;
    int n = matColSize[0];

    *returnSize = m;
    *returnColumnSizes = malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    int** dist = malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dist[i] = malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dist[i][j] = INT_MAX - 100000;
        }
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (mat[i][j] == 0) {
                dist[i][j] = 0;
            } else {
                if (i > 0) {
                    dist[i][j] = fmin(dist[i][j], dist[i-1][j] + 1);
                }
                if (j > 0) {
                    dist[i][j] = fmin(dist[i][j], dist[i][j-1] + 1);
                }
            }
        }
    }

    for (int i = m - 1; i >= 0; i--) {
        for (int j = n - 1; j >= 0; j--) {
            if (i < m - 1) {
                dist[i][j] = fmin(dist[i][j], dist[i+1][j] + 1);
            }
            if (j < n - 1) {
                dist[i][j] = fmin(dist[i][j], dist[i][j+1] + 1);
            }
        }
    }

    return dist;
}