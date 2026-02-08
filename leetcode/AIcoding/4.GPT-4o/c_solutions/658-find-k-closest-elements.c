#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* findClosestElements(int* arr, int arrSize, int k, int x, int* returnSize) {
    int left = 0, right = arrSize - 1;
    while (right - left >= k) {
        if (abs(arr[left] - x) > abs(arr[right] - x)) {
            right--;
        } else {
            left++;
        }
    }
    *returnSize = k;
    int* result = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        result[i] = arr[left + i];
    }
    return result;
}