/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the returned arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */
int** diagonalSort(int** mat, int matSize, int* matColSize, int* returnSize, int** returnColumnSizes) {
    int m = matSize;
    int n = *matColSize;

    int** result = (int**)malloc(m * sizeof(int*));
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    *returnSize = m;

    for (int i = 0; i < m; i++) {
        result[i] = (int*)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = n;
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            result[i][j] = mat[i][j];
        }
    }

    for (int i = 0; i < m; i++) {
        int diagSize = (m - i < n) ? m - i : n;
        int* diagonal = (int*)malloc(diagSize * sizeof(int));

        for (int k = 0; k < diagSize; k++) {
            diagonal[k] = mat[i + k][k];
        }

        for (int p = 0; p < diagSize - 1; p++) {
            for (int q = 0; q < diagSize - p - 1; q++) {
                if (diagonal[q] > diagonal[q + 1]) {
                    int temp = diagonal[q];
                    diagonal[q] = diagonal[q + 1];
                    diagonal[q + 1] = temp;
                }
            }
        }

        for (int k = 0; k < diagSize; k++) {
            result[i + k][k] = diagonal[k];
        }

        free(diagonal);
    }

    for (int j = 1; j < n; j++) {
        int diagSize = (m < n - j) ? m : n - j;
        int* diagonal = (int*)malloc(diagSize * sizeof(int));

        for (int k = 0; k < diagSize; k++) {
            diagonal[k] = mat[k][j + k];
        }

        for (int p = 0; p < diagSize - 1; p++) {
            for (int q = 0; q < diagSize - p - 1; q++) {
                if (diagonal[q] > diagonal[q + 1]) {
                    int temp = diagonal[q];
                    diagonal[q] = diagonal[q + 1];
                    diagonal[q + 1] = temp;
                }
            }
        }

        for (int k = 0; k < diagSize; k++) {
            result[k][j + k] = diagonal[k];
        }

        free(diagonal);
    }

    return result;
}