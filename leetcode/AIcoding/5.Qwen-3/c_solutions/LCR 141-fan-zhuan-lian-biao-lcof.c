#include <stdio.h>
#include <stdlib.h>

int* trainingPlan(int* cnt, int cntSize, int** returnSize, int** returnColumnSizes) {
    *returnSize = (int*)malloc(sizeof(int));
    *returnColumnSizes = (int*)malloc(cntSize * sizeof(int));
    int* result = (int*)malloc(cntSize * sizeof(int));
    for (int i = 0; i < cntSize; i++) {
        (*returnColumnSizes)[i] = cnt[i];
        result[i] = cnt[i];
    }
    *returnSize = cntSize;
    return result;
}