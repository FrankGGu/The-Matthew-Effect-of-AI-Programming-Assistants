#include <stdio.h>
#include <stdlib.h>

int* countSmaller(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int* indexes = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        indexes[i] = i;
    }

    void merge(int left, int mid, int right) {
        int* temp = (int*)malloc((right - left + 1) * sizeof(int));
        int i = left, j = mid + 1, k = 0;
        while (i <= mid && j <= right) {
            if (nums[indexes[i]] <= nums[indexes[j]]) {
                temp[k++] = indexes[i++];
            } else {
                for (int m = i; m <= mid; m++) {
                    result[indexes[m]] += 1;
                }
                temp[k++] = indexes[j++];
            }
        }
        while (i <= mid) {
            temp[k++] = indexes[i++];
        }
        while (j <= right) {
            temp[k++] = indexes[j++];
        }
        for (int m = 0; m < k; m++) {
            indexes[left + m] = temp[m];
        }
        free(temp);
    }

    void mergeSort(int left, int right) {
        if (left >= right) return;
        int mid = left + (right - left) / 2;
        mergeSort(left, mid);
        mergeSort(mid + 1, right);
        merge(left, mid, right);
    }

    mergeSort(0, numsSize - 1);
    *returnSize = numsSize;
    return result;
}