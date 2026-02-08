#include <stdio.h>
#include <stdlib.h>

int* findCommonElements(int* arr1, int arr1Size, int* arr2, int arr2Size, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * (arr1Size < arr2Size ? arr1Size : arr2Size));
    int index = 0;
    for (int i = 0; i < arr1Size; i++) {
        for (int j = 0; j < arr2Size; j++) {
            if (arr1[i] == arr2[j]) {
                result[index++] = arr1[i];
                break;
            }
        }
    }
    *returnSize = index;
    return result;
}