#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int comparePair(const void *a, const void *b) {
    int *x = (int*)a;
    int *y = (int*)b;
    if (x[1] != y[1]) return y[1] - x[1];
    return y[0] - x[0];
}

int* getStrongest(int* arr, int arrSize, int k, int* returnSize) {
    int* sorted = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        sorted[i] = arr[i];
    }
    qsort(sorted, arrSize, sizeof(int), compare);

    int m = arrSize / 2;
    int median = sorted[m];

    int** pairs = (int**)malloc(arrSize * sizeof(int*));
    for (int i = 0; i < arrSize; i++) {
        pairs[i] = (int*)malloc(2 * sizeof(int));
        pairs[i][0] = arr[i];
        pairs[i][1] = abs(arr[i] - median);
    }

    qsort(pairs, arrSize, sizeof(int*), comparePair);

    int* result = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        result[i] = pairs[i][0];
    }

    *returnSize = k;
    for (int i = 0; i < arrSize; i++) {
        free(pairs[i]);
    }
    free(pairs);
    free(sorted);
    return result;
}