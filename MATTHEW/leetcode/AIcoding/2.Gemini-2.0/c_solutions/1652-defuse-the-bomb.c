#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* decrypt(int* code, int codeSize, int k, int* returnSize){
    int *result = (int*)malloc(codeSize * sizeof(int));
    *returnSize = codeSize;

    for(int i = 0; i < codeSize; i++){
        int sum = 0;
        if(k > 0){
            for(int j = 1; j <= k; j++){
                sum += code[(i + j) % codeSize];
            }
        } else if(k < 0){
            for(int j = 1; j <= -k; j++){
                sum += code[(i - j + codeSize) % codeSize];
            }
        }
        result[i] = sum;
    }

    return result;
}