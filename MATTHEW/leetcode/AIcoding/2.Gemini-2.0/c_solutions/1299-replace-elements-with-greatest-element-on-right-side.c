#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* replaceElements(int* arr, int arrSize, int* returnSize){
    *returnSize = arrSize;
    if (arrSize == 0) {
        return arr;
    }

    int max_right = -1;
    for (int i = arrSize - 1; i >= 0; i--) {
        int temp = arr[i];
        arr[i] = max_right;
        if (temp > max_right) {
            max_right = temp;
        }
    }
    return arr;
}