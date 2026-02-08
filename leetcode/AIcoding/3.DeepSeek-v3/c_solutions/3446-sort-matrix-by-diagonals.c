/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** diagonalSort(int** mat, int matSize, int* matColSize, int* returnSize, int** returnColumnSizes) {
    int m = matSize;
    int n = matColSize[0];

    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    int** result = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        result[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            result[i][j] = mat[i][j];
        }
    }

    for (int i = 0; i < m; i++) {
        int len = (m - i < n) ? m - i : n;
        int* temp = (int*)malloc(len * sizeof(int));
        for (int k = 0; k < len; k++) {
            temp[k] = mat[i + k][k];
        }
        for (int p = 0; p < len - 1; p++) {
            for (int q = 0; q < len - p - 1; q++) {
                if (temp[q] > temp[q + 1]) {
                    int swap = temp[q];
                    temp[q] = temp[q + 1];
                    temp[q + 1] = swap;
                }
            }
        }
        for (int k = 0; k < len; k++) {
            result[i + k][k] = temp[k];
        }
        free(temp);
    }

    for (int j = 1; j < n; j++) {
        int len = (m < n - j) ? m : n - j;
        int* temp = (int*)malloc(len * sizeof(int));
        for (int k = 0; k < len; k++) {
            temp[k] = mat[k][j + k];
        }
        for (int p = 0; p < len - 1; p++) {
            for (int q = 0; q < len - p - 1; q++) {
                if (temp[q] > temp[q + 1]) {
                    int swap = temp[q];
                    temp[q] = temp[q + 1];
                    temp[q + 1] = swap;
                }
            }
        }
        for (int k = 0; k < len; k++) {
            result[k][j + k] = temp[k];
        }
        free(temp);
    }

    return result;
}