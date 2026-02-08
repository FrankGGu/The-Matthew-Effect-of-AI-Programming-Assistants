#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findClosestElements(int* arr, int arrSize, int k, int x, int* returnSize) {
    int left = 0;
    int right = arrSize - k;

    while (left < right) {
        int mid = left + (right - left) / 2;
        if (x - arr[mid] > arr[mid + k] - x) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    int* result = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        result[i] = arr[left + i];
    }

    *returnSize = k;
    return result;
}