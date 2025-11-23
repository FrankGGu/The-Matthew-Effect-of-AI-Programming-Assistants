#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numSpecial(int** mat, int matSize, int* matColSize){
    int rows[matSize];
    int cols[*matColSize];
    int count = 0;

    for(int i = 0; i < matSize; i++){
        rows[i] = 0;
    }
    for(int j = 0; j < *matColSize; j++){
        cols[j] = 0;
    }

    for(int i = 0; i < matSize; i++){
        for(int j = 0; j < *matColSize; j++){
            if(mat[i][j] == 1){
                rows[i]++;
                cols[j]++;
            }
        }
    }

    for(int i = 0; i < matSize; i++){
        for(int j = 0; j < *matColSize; j++){
            if(mat[i][j] == 1 && rows[i] == 1 && cols[j] == 1){
                count++;
            }
        }
    }

    return count;
}