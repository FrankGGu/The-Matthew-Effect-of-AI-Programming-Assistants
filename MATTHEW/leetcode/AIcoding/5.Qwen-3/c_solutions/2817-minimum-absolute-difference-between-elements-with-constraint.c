#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* minimumAbsoluteDifference(int* arr, int arrSize, int* returnSize) {
    qsort(arr, arrSize, sizeof(int), compare);
    int minDiff = INT_MAX;
    for (int i = 1; i < arrSize; i++) {
        minDiff = fmin(minDiff, arr[i] - arr[i-1]);
    }

    *returnSize = 0;
    int* result = (int*)malloc(arrSize * sizeof(int));

    for (int i = 1; i < arrSize; i++) {
        if (arr[i] - arr[i-1] == minDiff) {
            result[*returnSize] = arr[i-1];
            result[*returnSize + 1] = arr[i];
            *returnSize += 2;
        }
    }

    return result;
}