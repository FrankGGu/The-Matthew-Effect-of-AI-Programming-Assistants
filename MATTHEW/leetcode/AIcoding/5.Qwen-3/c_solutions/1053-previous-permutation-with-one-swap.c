#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* prevPermOpt1(int* arr, int arrSize, int* returnSize) {
    int* result = (int*)malloc(arrSize * sizeof(int));
    memcpy(result, arr, arrSize * sizeof(int));

    int i = arrSize - 2;
    while (i >= 0 && result[i] <= result[i + 1]) {
        i--;
    }

    if (i < 0) {
        *returnSize = arrSize;
        return result;
    }

    int j = arrSize - 1;
    while (result[j] >= result[i]) {
        j--;
    }

    while (j > i && result[j] == result[j - 1]) {
        j--;
    }

    int temp = result[i];
    result[i] = result[j];
    result[j] = temp;

    *returnSize = arrSize;
    return result;
}