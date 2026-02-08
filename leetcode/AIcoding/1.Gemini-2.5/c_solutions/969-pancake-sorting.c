#include <stdlib.h>

void reverse(int* arr, int start, int end) {
    while (start < end) {
        int temp = arr[start];
        arr[start] = arr[end];
        arr[end] = temp;
        start++;
        end--;
    }
}

int find_idx(int* arr, int size, int target_val) {
    for (int i = 0; i < size; i++) {
        if (arr[i] == target_val) {
            return i;
        }
    }
    return -1;
}

int* pancakeSort(int* arr, int arrSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 2 * arrSize);
    *returnSize = 0;

    for (int current_val = arrSize; current_val >= 1; current_val--) {
        int idx = find_idx(arr, current_val, current_val);

        if (idx == current_val - 1) {
            continue;
        }

        if (idx != 0) {
            reverse(arr, 0, idx);
            result[(*returnSize)++] = idx + 1;
        }

        reverse(arr, 0, current_val - 1);
        result[(*returnSize)++] = current_val;
    }

    return result;
}