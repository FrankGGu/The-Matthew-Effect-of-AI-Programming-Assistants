#include <stdio.h>
#include <stdlib.h>

int* minimumAbsDifference(int* arr, int arrSize, int* returnSize) {
    int* result = malloc(arrSize * sizeof(int) * 2);
    int count = 0;

    qsort(arr, arrSize, sizeof(int), cmp);

    int minDiff = INT_MAX;
    for (int i = 1; i < arrSize; i++) {
        int diff = arr[i] - arr[i - 1];
        if (diff < minDiff) {
            minDiff = diff;
            count = 0;
        }
        if (diff == minDiff) {
            result[count++] = arr[i - 1];
            result[count++] = arr[i];
        }
    }

    *returnSize = count / 2;
    return result;
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}