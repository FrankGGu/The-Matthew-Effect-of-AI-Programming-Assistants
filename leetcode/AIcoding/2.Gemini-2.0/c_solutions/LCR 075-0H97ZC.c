#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* relativeSortArray(int* arr1, int arr1Size, int* arr2, int arr2Size, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * arr1Size);
    int* remaining = (int*)malloc(sizeof(int) * arr1Size);
    int remainingSize = 0;
    int resultIndex = 0;
    int count[1001] = {0};

    for (int i = 0; i < arr1Size; i++) {
        count[arr1[i]]++;
    }

    for (int i = 0; i < arr2Size; i++) {
        while (count[arr2[i]] > 0) {
            result[resultIndex++] = arr2[i];
            count[arr2[i]]--;
        }
    }

    for (int i = 0; i <= 1000; i++) {
        while (count[i] > 0) {
            remaining[remainingSize++] = i;
            count[i]--;
        }
    }

    qsort(remaining, remainingSize, sizeof(int), compare);

    for (int i = 0; i < remainingSize; i++) {
        result[resultIndex++] = remaining[i];
    }

    free(remaining);
    *returnSize = arr1Size;
    return result;
}

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}