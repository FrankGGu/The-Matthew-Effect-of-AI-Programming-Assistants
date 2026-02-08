#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* transformArray(int* arr, int arrSize, int* returnSize) {
    if (arrSize <= 2) {
        *returnSize = arrSize;
        int* result = (int*)malloc(arrSize * sizeof(int));
        for (int i = 0; i < arrSize; i++) {
            result[i] = arr[i];
        }
        return result;
    }

    int* temp = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        temp[i] = arr[i];
    }

    int changed = 1;
    while (changed) {
        changed = 0;
        for (int i = 1; i < arrSize - 1; i++) {
            if (arr[i - 1] > arr[i] && arr[i + 1] > arr[i]) {
                temp[i] = arr[i] + 1;
                changed = 1;
            } else if (arr[i - 1] < arr[i] && arr[i + 1] < arr[i]) {
                temp[i] = arr[i] - 1;
                changed = 1;
            } else {
                temp[i] = arr[i];
            }
        }

        for (int i = 0; i < arrSize; i++) {
            arr[i] = temp[i];
        }
    }

    *returnSize = arrSize;
    return arr;
}