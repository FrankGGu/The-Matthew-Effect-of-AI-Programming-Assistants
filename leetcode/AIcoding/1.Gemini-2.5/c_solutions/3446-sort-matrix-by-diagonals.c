#include <stdlib.h> // For malloc, free, qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int** diagonalSort(int** mat, int matSize, int* matColSize, int* returnSize, int** returnColumnSizes) {
    int m = matSize;
    int n = matColSize[0];

    *returnSize = m;
    *returnColumnSizes = (int*)malloc(sizeof(int) * m);
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    int max_diag_len = (m < n) ? m : n;
    int* diag_elements = (int*)malloc(sizeof(int) * max_diag_len);

    for (int k = 1 - n; k < m; k++) {
        int count = 0;
        int r_start, c_start;

        if (k >= 0) {
            r_start = k;
            c_start = 0;
        } else {
            r_start = 0;
            c_start = -k;
        }

        for (int r = r_start, c = c_start; r < m && c < n; r++, c++) {
            diag_elements[count++] = mat[r][c];
        }

        qsort(diag_elements, count, sizeof(int), compare);

        int current_idx = 0;
        for (int r = r_start, c = c_start; r < m && c < n; r++, c++) {
            mat[r][c] = diag_elements[current_idx++];
        }
    }

    free(diag_elements);

    return mat;
}