#include <stdio.h>
#include <stdlib.h>

int oddCells(int n, int m, int* indices, int indicesSize) {
    int* row = (int*)calloc(n, sizeof(int));
    int* col = (int*)calloc(m, sizeof(int));

    for (int i = 0; i < indicesSize; i++) {
        int r = indices[i];
        int c = indices[++i];
        row[r]++;
        col[c]++;
    }

    int count = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            if ((row[i] + col[j]) % 2 == 1) {
                count++;
            }
        }
    }

    free(row);
    free(col);
    return count;
}