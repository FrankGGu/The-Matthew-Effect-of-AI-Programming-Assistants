#include <stdio.h>
#include <stdlib.h>

int* targetIndices(int* target, int targetSize, int* arr, int arrSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * targetSize);
    int index = 0;

    for (int i = 0; i < arrSize; i++) {
        for (int j = 0; j < targetSize; j++) {
            if (arr[i] == target[j]) {
                result[index++] = i;
                break;
            }
        }
    }

    *returnSize = index;
    return result;
}