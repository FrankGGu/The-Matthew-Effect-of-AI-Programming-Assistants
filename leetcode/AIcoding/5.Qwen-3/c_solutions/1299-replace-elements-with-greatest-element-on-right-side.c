#include <stdio.h>
#include <stdlib.h>

int* replaceElements(int* arr, int arrSize, int* returnSize) {
    int* result = (int*)malloc(arrSize * sizeof(int));
    int maxVal = arr[arrSize - 1];
    result[arrSize - 1] = -1;

    for (int i = arrSize - 2; i >= 0; i--) {
        int temp = arr[i];
        result[i] = maxVal;
        if (temp > maxVal) {
            maxVal = temp;
        }
    }

    *returnSize = arrSize;
    return result;
}