#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* rowAndMaximumOnes(int** mat, int matSize, int* matColSize, int* returnSize){
    int max_ones = -1;
    int row_index = -1;

    for(int i = 0; i < matSize; i++){
        int current_ones = 0;
        for(int j = 0; j < matColSize[i]; j++){
            if(mat[i][j] == 1){
                current_ones++;
            }
        }

        if(current_ones > max_ones){
            max_ones = current_ones;
            row_index = i;
        }
    }

    int *result = (int*)malloc(sizeof(int) * 2);
    result[0] = row_index;
    result[1] = max_ones;
    *returnSize = 2;
    return result;
}