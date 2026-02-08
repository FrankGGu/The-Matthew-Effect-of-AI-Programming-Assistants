#include <stdio.h>
#include <stdlib.h>

int* stableMountains(int* arr, int arrSize, int* returnSize) {
    int* result = (int*)malloc(arrSize * sizeof(int));
    int count = 0;

    for (int i = 1; i < arrSize; i++) {
        if (arr[i - 1] > arr[i]) {
            result[count++] = i;
        }
    }

    *returnSize = count;
    return result;
}