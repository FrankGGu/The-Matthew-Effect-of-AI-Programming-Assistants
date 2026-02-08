#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int* getStrongest(int* arr, int arrSize, int k, int* returnSize) {
    int* sorted = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        sorted[i] = arr[i];
    }

    for (int i = 0; i < arrSize - 1; i++) {
        for (int j = 0; j < arrSize - i - 1; j++) {
            if (sorted[j] > sorted[j + 1]) {
                int temp = sorted[j];
                sorted[j] = sorted[j + 1];
                sorted[j + 1] = temp;
            }
        }
    }

    int m = arrSize - 1;
    int median = sorted[m / 2];

    int* result = (int*)malloc(k * sizeof(int));
    *returnSize = k;

    int left = 0;
    int right = arrSize - 1;
    int index = 0;

    while (index < k) {
        if (abs(sorted[left] - median) > abs(sorted[right] - median)) {
            result[index++] = sorted[left++];
        } else {
            result[index++] = sorted[right--];
        }
    }

    free(sorted);
    return result;
}