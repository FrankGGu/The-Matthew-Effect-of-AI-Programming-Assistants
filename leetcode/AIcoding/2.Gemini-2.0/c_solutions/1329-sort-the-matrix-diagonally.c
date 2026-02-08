#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void sortMatrixDiagonally(int** mat, int matSize, int* matColSize) {
    int m = matSize;
    int n = matColSize[0];
    int len = m > n ? m : n;
    int* diagonal = (int*)malloc(len * sizeof(int));

    for (int k = 0; k < n; k++) {
        int i = 0, j = k, count = 0;
        while (i < m && j < n) {
            diagonal[count++] = mat[i][j];
            i++;
            j++;
        }
        for (int x = 0; x < count - 1; x++) {
            for (int y = 0; y < count - x - 1; y++) {
                if (diagonal[y] > diagonal[y + 1]) {
                    int temp = diagonal[y];
                    diagonal[y] = diagonal[y + 1];
                    diagonal[y + 1] = temp;
                }
            }
        }
        i = 0, j = k, count = 0;
        while (i < m && j < n) {
            mat[i][j] = diagonal[count++];
            i++;
            j++;
        }
    }

    for (int k = 1; k < m; k++) {
        int i = k, j = 0, count = 0;
        while (i < m && j < n) {
            diagonal[count++] = mat[i][j];
            i++;
            j++;
        }
        for (int x = 0; x < count - 1; x++) {
            for (int y = 0; y < count - x - 1; y++) {
                if (diagonal[y] > diagonal[y + 1]) {
                    int temp = diagonal[y];
                    diagonal[y] = diagonal[y + 1];
                    diagonal[y + 1] = temp;
                }
            }
        }
        i = k, j = 0, count = 0;
        while (i < m && j < n) {
            mat[i][j] = diagonal[count++];
            i++;
            j++;
        }
    }

    free(diagonal);
}