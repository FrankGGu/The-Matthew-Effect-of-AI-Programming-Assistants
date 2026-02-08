#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* constructBitwiseArray(int arr[], int arrSize, int* returnSize) {
    int andVal = arr[0];
    for (int i = 1; i < arrSize; i++) {
        andVal &= arr[i];
    }

    int* result = (int*)malloc(arrSize * sizeof(int));
    *returnSize = arrSize;

    for (int i = 0; i < arrSize; i++) {
        result[i] = andVal;
    }

    return result;
}