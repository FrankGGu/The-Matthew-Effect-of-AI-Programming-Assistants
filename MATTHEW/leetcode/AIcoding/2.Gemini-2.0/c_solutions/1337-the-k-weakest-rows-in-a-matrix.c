#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* kWeakestRows(int** mat, int matSize, int* matColSize, int k, int* returnSize){
    int* strengths = (int*)malloc(matSize * sizeof(int));
    int* indices = (int*)malloc(matSize * sizeof(int));
    *returnSize = k;

    for (int i = 0; i < matSize; i++) {
        int strength = 0;
        for (int j = 0; j < matColSize[i]; j++) {
            if (mat[i][j] == 1) {
                strength++;
            } else {
                break;
            }
        }
        strengths[i] = strength;
        indices[i] = i;
    }

    for (int i = 0; i < matSize - 1; i++) {
        for (int j = 0; j < matSize - i - 1; j++) {
            if (strengths[j] > strengths[j + 1] || (strengths[j] == strengths[j + 1] && indices[j] > indices[j + 1])) {
                int tempStrength = strengths[j];
                strengths[j] = strengths[j + 1];
                strengths[j + 1] = tempStrength;

                int tempIndex = indices[j];
                indices[j] = indices[j + 1];
                indices[j + 1] = tempIndex;
            }
        }
    }

    int* result = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        result[i] = indices[i];
    }

    free(strengths);
    free(indices);

    return result;
}