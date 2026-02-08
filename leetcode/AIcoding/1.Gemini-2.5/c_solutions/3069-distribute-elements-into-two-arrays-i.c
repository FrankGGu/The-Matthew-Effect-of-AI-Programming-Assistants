#include <stdlib.h>

int* distributeElements(int* nums, int numsSize, int* returnSize) {
    int* arr1 = (int*)malloc(numsSize * sizeof(int));
    int* arr2 = (int*)malloc(numsSize * sizeof(int));
    int arr1_idx = 0;
    int arr2_idx = 0;

    arr1[arr1_idx++] = nums[0];
    arr2[arr2_idx++] = nums[1];

    for (int i = 2; i < numsSize; i++) {
        if (arr1[arr1_idx - 1] > arr2[arr2_idx - 1]) {
            arr1[arr1_idx++] = nums[i];
        } else {
            arr2[arr2_idx++] = nums[i];
        }
    }

    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));
    int result_idx = 0;

    for (int i = 0; i < arr1_idx; i++) {
        result[result_idx++] = arr1[i];
    }
    for (int i = 0; i < arr2_idx; i++) {
        result[result_idx++] = arr2[i];
    }

    free(arr1);
    free(arr2);

    return result;
}