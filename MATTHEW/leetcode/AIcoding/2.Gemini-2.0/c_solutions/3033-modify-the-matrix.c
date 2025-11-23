#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** modifiedMatrix(int** matrix, int matrixSize, int* matrixColSize, int* returnSize, int** returnColumnSizes){
    *returnSize = matrixSize;
    *returnColumnSizes = (int*)malloc(matrixSize * sizeof(int));
    for(int i = 0; i < matrixSize; i++){
        (*returnColumnSizes)[i] = matrixColSize[0];
    }

    int max_cols[matrixColSize[0]];
    for(int j = 0; j < matrixColSize[0]; j++){
        max_cols[j] = -1000000;
    }

    for(int j = 0; j < matrixColSize[0]; j++){
        for(int i = 0; i < matrixSize; i++){
            if(matrix[i][j] > max_cols[j]){
                max_cols[j] = matrix[i][j];
            }
        }
    }

    for(int i = 0; i < matrixSize; i++){
        for(int j = 0; j < matrixColSize[0]; j++){
            if(matrix[i][j] == -1){
                matrix[i][j] = max_cols[j];
            }
        }
    }

    return matrix;
}