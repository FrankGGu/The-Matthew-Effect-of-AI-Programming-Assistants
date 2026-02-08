#include <stdio.h>
#include <stdlib.h>

int* longestCommonPrefix(int* arr, int arrSize, int* returnSize) {
    if (arrSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(arrSize * sizeof(int));
    int count = 0;

    for (int i = 0; i < arrSize; i++) {
        int current = arr[i];
        int next = (i + 1 < arrSize) ? arr[i + 1] : 0;

        if (current < next) {
            count = 1;
        } else {
            count++;
        }

        result[i] = count;
    }

    *returnSize = arrSize;
    return result;
}