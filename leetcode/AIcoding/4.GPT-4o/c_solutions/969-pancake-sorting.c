#include <stdio.h>
#include <stdlib.h>

void flip(int* arr, int k) {
    int left = 0, right = k;
    while (left < right) {
        int temp = arr[left];
        arr[left] = arr[right];
        arr[right] = temp;
        left++;
        right--;
    }
}

int* pancakeSort(int* arr, int arrSize, int* returnSize) {
    int* result = (int*)malloc(arrSize * sizeof(int));
    *returnSize = 0;

    for (int curr_size = arrSize; curr_size > 1; curr_size--) {
        int max_idx = 0;
        for (int i = 1; i < curr_size; i++) {
            if (arr[i] > arr[max_idx]) {
                max_idx = i;
            }
        }

        if (max_idx != curr_size - 1) {
            if (max_idx > 0) {
                result[(*returnSize)++] = max_idx + 1;
                flip(arr, max_idx);
            }
            result[(*returnSize)++] = curr_size;
            flip(arr, curr_size - 1);
        }
    }

    return result;
}