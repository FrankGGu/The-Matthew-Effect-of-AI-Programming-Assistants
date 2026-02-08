#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findDiagonalOrder(int** mat, int matSize, int* matColSize, int* returnSize){
    if (matSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int rows = matSize;
    int cols = matColSize[0];
    *returnSize = rows * cols;
    int* result = (int*)malloc(sizeof(int) * (*returnSize));
    int row = 0, col = 0;
    int index = 0;
    int up = 1; 

    while (row < rows && col < cols) {
        result[index++] = mat[row][col];

        if (up) {
            if (row - 1 >= 0 && col + 1 < cols) {
                row--;
                col++;
            } else {
                if (col + 1 < cols) {
                    col++;
                } else {
                    row++;
                }
                up = 0;
            }
        } else {
            if (row + 1 < rows && col - 1 >= 0) {
                row++;
                col--;
            } else {
                if (row + 1 < rows) {
                    row++;
                } else {
                    col++;
                }
                up = 1;
            }
        }
    }

    return result;
}