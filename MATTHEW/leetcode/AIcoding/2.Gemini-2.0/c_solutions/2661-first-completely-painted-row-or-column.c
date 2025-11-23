#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int firstCompleteIndex(int* arr, int arrSize, int** mat, int matSize, int matColSize){
    int row_count[matSize];
    int col_count[matColSize[0]];

    for (int i = 0; i < matSize; i++) {
        row_count[i] = 0;
    }
    for (int i = 0; i < matColSize[0]; i++) {
        col_count[i] = 0;
    }

    for (int i = 0; i < arrSize; i++) {
        int val = arr[i];
        int row = -1, col = -1;
        for (int r = 0; r < matSize; r++) {
            for (int c = 0; c < matColSize[0]; c++) {
                if (mat[r][c] == val) {
                    row = r;
                    col = c;
                    break;
                }
            }
            if (row != -1) break;
        }

        row_count[row]++;
        col_count[col]++;

        if (row_count[row] == matColSize[0]) return i;
        if (col_count[col] == matSize) return i;
    }

    return -1;
}