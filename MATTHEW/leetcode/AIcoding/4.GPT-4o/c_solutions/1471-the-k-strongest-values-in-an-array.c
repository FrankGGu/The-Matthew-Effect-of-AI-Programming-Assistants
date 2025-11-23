#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int *)b - *(int *)a);
}

int* getStrongest(int* arr, int arrSize, int k, int* returnSize) {
    int* result = (int*)malloc(k * sizeof(int));
    int midIdx = (arrSize - 1) / 2;
    qsort(arr, arrSize, sizeof(int), cmp);
    int midValue = arr[midIdx];

    int left = 0, right = arrSize - 1, idx = 0;
    while (idx < k) {
        if (left <= midIdx && (right < midIdx || abs(arr[left] - midValue) > abs(arr[right] - midValue))) {
            result[idx++] = arr[left++];
        } else {
            result[idx++] = arr[right--];
        }
    }

    *returnSize = k;
    return result;
}