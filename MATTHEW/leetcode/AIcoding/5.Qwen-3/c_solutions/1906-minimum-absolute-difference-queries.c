#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* minimumAbsoluteDifference(int* arr, int arrSize, int** queries, int queriesSize, int* returnSize) {
    qsort(arr, arrSize, sizeof(int), compare);
    int* result = (int*)malloc(queriesSize * sizeof(int));
    for (int i = 0; i < queriesSize; i++) {
        int k = queries[i][0];
        int x = queries[i][1];
        int minDiff = INT_MAX;
        for (int j = 0; j < arrSize; j++) {
            int diff = abs(arr[j] - x);
            if (diff < minDiff) {
                minDiff = diff;
            }
        }
        result[i] = minDiff;
    }
    *returnSize = queriesSize;
    return result;
}