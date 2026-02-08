#include <stdio.h>
#include <stdlib.h>

long long* minArrayEnd(int* arr1, int arr1Size, int* arr2, int arr2Size, int* returnSize) {
    long long* result = (long long*)malloc(arr1Size * sizeof(long long));
    *returnSize = arr1Size;

    int i = 0, j = 0;
    while (i < arr1Size || j < arr2Size) {
        if (i < arr1Size && (j >= arr2Size || arr1[i] < arr2[j])) {
            result[i + j] = arr1[i];
            i++;
        } else {
            result[i + j] = arr2[j];
            j++;
        }
    }

    return result;
}