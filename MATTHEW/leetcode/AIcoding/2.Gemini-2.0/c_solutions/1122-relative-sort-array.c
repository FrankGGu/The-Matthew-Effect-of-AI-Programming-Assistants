#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* relativeSortArray(int* arr1, int arr1Size, int* arr2, int arr2Size, int* returnSize) {
    int* result = (int*)malloc(arr1Size * sizeof(int));
    *returnSize = 0;
    int counts[1001] = {0};

    for (int i = 0; i < arr1Size; i++) {
        counts[arr1[i]]++;
    }

    for (int i = 0; i < arr2Size; i++) {
        while (counts[arr2[i]] > 0) {
            result[(*returnSize)++] = arr2[i];
            counts[arr2[i]]--;
        }
    }

    for (int i = 0; i < 1001; i++) {
        while (counts[i] > 0) {
            result[(*returnSize)++] = i;
            counts[i]--;
        }
    }

    return result;
}