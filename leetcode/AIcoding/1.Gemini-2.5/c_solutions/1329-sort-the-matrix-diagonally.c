#include <stdlib.h>
#include <string.h>

int compareInts(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int** diagonalSort(int** mat, int matSize, int* matColSize, int* returnSize, int** returnColumnSizes) {
    int m = matSize;
    int n = matColSize[0];

    int** result = (int**)malloc(m * sizeof(int*));
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        result[i] = (int*)malloc(n * sizeof(int));
        memcpy(result[i], mat[i], n * sizeof(int));
        (*returnColumnSizes)[i] = n;
    }
    *returnSize = m;

    int* temp_diag = (int*)malloc(sizeof(int) * (m < n ? m : n)); 

    for (int j = 0; j < n; j++) {
        int count = 0;
        int r = 0;
        int c = j;
        while (r < m && c < n) {
            temp_diag[count++] = result[r][c];
            r++;
            c++;
        }
        qsort(temp_diag, count, sizeof(int), compareInts);

        r = 0;
        c = j;
        int k = 0;
        while (r < m && c < n) {
            result[r][c] = temp_diag[k++];
            r++;
            c++;
        }
    }

    for (int i = 1; i < m; i++) {
        int count = 0;
        int r = i;
        int c = 0;
        while (r < m && c < n) {
            temp_diag[count++] = result[r][c];
            r++;
            c++;
        }
        qsort(temp_diag, count, sizeof(int), compareInts);

        r = i;
        c = 0;
        int k = 0;
        while (r < m && c < n) {
            result[r][c] = temp_diag[k++];
            r++;
            c++;
        }
    }

    free(temp_diag);
    return result;
}