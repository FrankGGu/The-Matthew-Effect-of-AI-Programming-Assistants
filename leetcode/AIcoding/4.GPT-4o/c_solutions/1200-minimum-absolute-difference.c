#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minimumAbsDifference(int* arr, int arrSize, int** returnArray, int* returnSize) {
    qsort(arr, arrSize, sizeof(int), cmp);
    int minDiff = INT_MAX;
    *returnSize = 0;

    for (int i = 1; i < arrSize; i++) {
        int diff = arr[i] - arr[i - 1];
        if (diff < minDiff) {
            minDiff = diff;
            *returnSize = 0;
        }
        if (diff == minDiff) {
            (*returnSize)++;
        }
    }

    *returnArray = (int**)malloc((*returnSize) * sizeof(int*));
    for (int i = 0, j = 1; j < arrSize; j++) {
        if (arr[j] - arr[j - 1] == minDiff) {
            (*returnArray)[i] = (int*)malloc(2 * sizeof(int));
            (*returnArray)[i][0] = arr[j - 1];
            (*returnArray)[i][1] = arr[j];
            i++;
        }
    }

    return minDiff;
}