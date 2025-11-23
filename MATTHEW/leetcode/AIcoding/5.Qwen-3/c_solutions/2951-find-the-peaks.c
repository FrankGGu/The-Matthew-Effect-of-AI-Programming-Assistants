#include <stdio.h>
#include <stdlib.h>

int* peakIndexInMountainArray(int* arr, int size, int* returnSize) {
    int* result = (int*)malloc(sizeof(int));
    *returnSize = 0;

    for (int i = 1; i < size - 1; i++) {
        if (arr[i] > arr[i - 1] && arr[i] > arr[i + 1]) {
            result[*returnSize] = i;
            (*returnSize)++;
            result = (int*)realloc(result, (*returnSize + 1) * sizeof(int));
        }
    }

    return result;
}