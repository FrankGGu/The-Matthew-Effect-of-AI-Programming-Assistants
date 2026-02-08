#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minimumAbsDifference(int* arr, int arrSize, int** returnColumnSizes, int* returnSize) {
    qsort(arr, arrSize, sizeof(int), compare);

    int min_diff = 200001;
    for (int i = 0; i < arrSize - 1; i++) {
        int diff = abs(arr[i] - arr[i+1]);
        if (diff < min_diff) {
            min_diff = diff;
        }
    }

    int count = 0;
    for (int i = 0; i < arrSize - 1; i++) {
        if (abs(arr[i] - arr[i+1]) == min_diff) {
            count++;
        }
    }

    int** result = (int**)malloc(count * sizeof(int*));
    *returnColumnSizes = (int*)malloc(count * sizeof(int));
    *returnSize = count;

    int index = 0;
    for (int i = 0; i < arrSize - 1; i++) {
        if (abs(arr[i] - arr[i+1]) == min_diff) {
            result[index] = (int*)malloc(2 * sizeof(int));
            result[index][0] = arr[i];
            result[index][1] = arr[i+1];
            (*returnColumnSizes)[index] = 2;
            index++;
        }
    }

    return result;
}