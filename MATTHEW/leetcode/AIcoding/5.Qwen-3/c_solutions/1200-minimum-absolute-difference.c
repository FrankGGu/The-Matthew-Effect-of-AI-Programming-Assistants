#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int** minimumAbsDiff(int* arr, int arrSize, int* returnSize, int** returnColumnSizes) {
    int i, j;
    int minDiff = INT_MAX;
    int** result;
    int count = 0;

    qsort(arr, arrSize, sizeof(int), (int (*)(const void*, const void*))strcmp);

    for (i = 0; i < arrSize - 1; i++) {
        int diff = arr[i + 1] - arr[i];
        if (diff < minDiff) {
            minDiff = diff;
        }
    }

    for (i = 0; i < arrSize - 1; i++) {
        if (arr[i + 1] - arr[i] == minDiff) {
            count++;
        }
    }

    *returnSize = count;
    *returnColumnSizes = (int*)malloc(sizeof(int) * count);
    result = (int**)malloc(sizeof(int*) * count);

    for (i = 0, j = 0; i < arrSize - 1; i++) {
        if (arr[i + 1] - arr[i] == minDiff) {
            result[j] = (int*)malloc(sizeof(int) * 2);
            result[j][0] = arr[i];
            result[j][1] = arr[i + 1];
            (*returnColumnSizes)[j] = 2;
            j++;
        }
    }

    return result;
}