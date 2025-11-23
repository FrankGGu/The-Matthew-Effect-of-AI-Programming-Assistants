/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** updateMatrix(int** mat, int matSize, int* matColSize, int* returnSize, int** returnColumnSizes) {
    int rows = matSize;
    int cols = matColSize[0];

    *returnSize = rows;
    *returnColumnSizes = malloc(rows * sizeof(int));
    for (int i = 0; i < rows; i++) {
        (*returnColumnSizes)[i] = cols;
    }

    int** dist = malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dist[i] = malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            dist[i][j] = INT_MAX - 100000;
        }
    }

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
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

    for (int i = rows - 1; i >= 0; i--) {
        for (int j = cols - 1; j >= 0; j--) {
            if (i < rows - 1) {
                dist[i][j] = fmin(dist[i][j], dist[i+1][j] + 1);
            }
            if (j < cols - 1) {
                dist[i][j] = fmin(dist[i][j], dist[i][j+1] + 1);
            }
        }
    }

    return dist;
}