#include <stdio.h>
#include <stdlib.h>

#define MAX(a, b) ((a) > (b) ? (a) : (b))

void sortDiagonal(int** mat, int matSize, int* matColSize, int row, int col) {
    int i = row, j = col;
    int count = 0;
    int diagonal[100]; // As max size can be 100 x 100

    while (i < matSize && j < *matColSize) {
        diagonal[count++] = mat[i][j];
        i++;
        j++;
    }

    qsort(diagonal, count, sizeof(int), cmp);

    i = row, j = col, count = 0;
    while (i < matSize && j < *matColSize) {
        mat[i][j] = diagonal[count++];
        i++;
        j++;
    }
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

void diagonalSort(int** mat, int matSize, int* matColSize) {
    for (int i = 0; i < matSize; i++) {
        sortDiagonal(mat, matSize, matColSize, i, 0);
    }
    for (int j = 1; j < *matColSize; j++) {
        sortDiagonal(mat, matSize, matColSize, 0, j);
    }
}