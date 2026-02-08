#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* relativeSortArray(int* arr1, int arr1Size, int* arr2, int arr2Size, int* returnSize) {
    int* result = (int*)malloc(arr1Size * sizeof(int));
    int index = 0;

    for (int i = 0; i < arr2Size; i++) {
        for (int j = 0; j < arr1Size; j++) {
            if (arr1[j] == arr2[i]) {
                result[index++] = arr1[j];
                arr1[j] = -1;
            }
        }
    }

    int* remaining = (int*)malloc((arr1Size - index) * sizeof(int));
    int remainingIndex = 0;

    for (int i = 0; i < arr1Size; i++) {
        if (arr1[i] != -1) {
            remaining[remainingIndex++] = arr1[i];
        }
    }

    qsort(remaining, remainingIndex, sizeof(int), compare);

    for (int i = 0; i < remainingIndex; i++) {
        result[index++] = remaining[i];
    }

    free(remaining);
    *returnSize = index;
    return result;
}