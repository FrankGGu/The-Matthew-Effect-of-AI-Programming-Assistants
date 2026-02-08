#include <stdio.h>
#include <stdlib.h>

int* canBeEqual(int* target, int targetSize, int* arr, int arrSize, int* returnSize) {
    int* result = (int*)malloc(targetSize * sizeof(int));
    *returnSize = targetSize;
    for (int i = 0; i < targetSize; i++) {
        result[i] = 0;
    }
    for (int i = 0; i < targetSize; i++) {
        if (target[i] == arr[i]) {
            result[i] = 1;
        } else {
            int found = 0;
            for (int j = i + 1; j < arrSize; j++) {
                if (arr[j] == target[i]) {
                    int temp = arr[i];
                    arr[i] = arr[j];
                    arr[j] = temp;
                    result[i] = 1;
                    found = 1;
                    break;
                }
            }
            if (!found) {
                *returnSize = 0;
                free(result);
                return NULL;
            }
        }
    }
    return result;
}