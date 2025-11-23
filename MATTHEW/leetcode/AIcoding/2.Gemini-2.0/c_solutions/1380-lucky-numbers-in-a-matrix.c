#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 50

int* luckyNumbers(int** matrix, int matrixSize, int* matrixColSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * matrixSize * (*matrixColSize));
    *returnSize = 0;

    for (int i = 0; i < matrixSize; i++) {
        int min_row = matrix[i][0];
        int col_index = 0;
        for (int j = 1; j < (*matrixColSize); j++) {
            if (matrix[i][j] < min_row) {
                min_row = matrix[i][j];
                col_index = j;
            }
        }

        int max_col = matrix[0][col_index];
        int is_lucky = 1;
        for (int k = 1; k < matrixSize; k++) {
            if (matrix[k][col_index] > max_col) {
                max_col = matrix[k][col_index];

            }
        }

        if(min_row == max_col){
            result[*returnSize] = min_row;
            (*returnSize)++;
        }
    }

    return result;
}