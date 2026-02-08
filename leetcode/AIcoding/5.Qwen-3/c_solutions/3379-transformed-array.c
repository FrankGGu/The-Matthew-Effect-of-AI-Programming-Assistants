#include <stdio.h>
#include <stdlib.h>

int* transformArray(int* arr, int arrSize, int* returnSize) {
    int* result = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        result[i] = arr[i];
    }
    for (int i = 1; i < arrSize - 1; i++) {
        if (arr[i - 1] == arr[i + 1]) {
            result[i] = arr[i] + 1;
        } else {
            result[i] = arr[i] - 1;
        }
    }
    *returnSize = arrSize;
    return result;
}