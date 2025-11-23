#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int kthSmallest(int** mat, int matSize, int* matColSize, int k) {
    int* sums = (int*)malloc(sizeof(int) * (matColSize[0] > k ? k : matColSize[0]));
    for (int i = 0; i < (matColSize[0] > k ? k : matColSize[0]); i++) {
        sums[i] = mat[0][i];
    }

    int sumsSize = (matColSize[0] > k ? k : matColSize[0]);

    for (int i = 1; i < matSize; i++) {
        int* newSums = (int*)malloc(sizeof(int) * (sumsSize * matColSize[i] > k ? k : sumsSize * matColSize[i]));
        int newSumsSize = 0;

        for (int j = 0; j < sumsSize; j++) {
            for (int l = 0; l < matColSize[i]; l++) {
                newSums[newSumsSize++] = sums[j] + mat[i][l];
            }
        }

        qsort(newSums, newSumsSize, sizeof(int), (int (*)(const void *, const void *))cmpfunc);

        free(sums);
        sums = (int*)malloc(sizeof(int) * (newSumsSize > k ? k : newSumsSize));
        sumsSize = (newSumsSize > k ? k : newSumsSize);

        for(int j = 0; j < sumsSize; j++){
            sums[j] = newSums[j];
        }

        free(newSums);

        if(sumsSize > k){
            sumsSize = k;
        }
    }

    qsort(sums, sumsSize, sizeof(int), (int (*)(const void *, const void *))cmpfunc);

    int result = sums[k - 1];
    free(sums);
    return result;
}

int cmpfunc(const void * a, const void * b) {
   return ( *(int*)a - *(int*)b );
}