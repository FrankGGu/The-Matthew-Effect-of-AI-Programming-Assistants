#include <stdlib.h>

int* replaceElements(int* arr, int arrSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * arrSize);
    *returnSize = arrSize;

    if (arrSize == 0) {
        return result;
    }

    if (arrSize == 1) {
        result[0] = -1;
        return result;
    }

    int maxRight = -1;
    for (int i = arrSize - 1; i >= 0; i--) {
        int currentElement = arr[i];
        result[i] = maxRight;
        if (currentElement > maxRight) {
            maxRight = currentElement;
        }
    }

    return result;
}