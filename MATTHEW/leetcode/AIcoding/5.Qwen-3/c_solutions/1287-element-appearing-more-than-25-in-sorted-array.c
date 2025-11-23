#include <stdio.h>
#include <stdlib.h>

int* findSpecialInteger(int* arr, int arrSize, int* returnSize) {
    *returnSize = 1;
    int* result = (int*)malloc(sizeof(int));
    int target = arrSize / 4;
    int count = 1;
    for (int i = 1; i < arrSize; i++) {
        if (arr[i] == arr[i - 1]) {
            count++;
            if (count > target) {
                result[0] = arr[i];
                return result;
            }
        } else {
            count = 1;
        }
    }
    result[0] = arr[0];
    return result;
}