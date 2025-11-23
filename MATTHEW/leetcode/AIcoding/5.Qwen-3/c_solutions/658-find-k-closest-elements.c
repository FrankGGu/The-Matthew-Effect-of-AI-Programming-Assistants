#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int* findClosestElements(int* arr, int arrSize, int k, int* returnSize) {
    int left = 0;
    int right = arrSize - 1;

    while (right - left >= k) {
        if (abs(arr[left] - arr[right]) > abs(arr[left + 1] - arr[right])) {
            left++;
        } else {
            right--;
        }
    }

    int* result = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; i++) {
        result[i] = arr[left + i];
    }

    *returnSize = k;
    return result;
}