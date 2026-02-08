#include <stdio.h>
#include <stdlib.h>

int* findKDistantIndices(int* arr, int arrSize, int k, int* returnSize) {
    int* result = (int*)malloc(arrSize * sizeof(int));
    int index = 0;

    for (int i = 0; i < arrSize; i++) {
        for (int j = 0; j < arrSize; j++) {
            if (abs(i - j) <= k) {
                result[index++] = j;
                break;
            }
        }
    }

    *returnSize = index;
    return result;
}