#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int** mergeSimilarItems(int** items1, int items1Size, int* items1ColSize, int** items2, int items2Size, int* items2ColSize, int* returnSize, int** returnColumnSizes){
    int* weights = (int*)calloc(1001, sizeof(int));
    for (int i = 0; i < items1Size; i++) {
        weights[items1[i][0]] += items1[i][1];
    }
    for (int i = 0; i < items2Size; i++) {
        weights[items2[i][0]] += items2[i][1];
    }

    int count = 0;
    for (int i = 1; i <= 1000; i++) {
        if (weights[i] > 0) {
            count++;
        }
    }

    int** result = (int**)malloc(count * sizeof(int*));
    *returnColumnSizes = (int*)malloc(count * sizeof(int));
    *returnSize = count;

    int index = 0;
    for (int i = 1; i <= 1000; i++) {
        if (weights[i] > 0) {
            result[index] = (int*)malloc(2 * sizeof(int));
            result[index][0] = i;
            result[index][1] = weights[i];
            (*returnColumnSizes)[index] = 2;
            index++;
        }
    }

    free(weights);
    return result;
}