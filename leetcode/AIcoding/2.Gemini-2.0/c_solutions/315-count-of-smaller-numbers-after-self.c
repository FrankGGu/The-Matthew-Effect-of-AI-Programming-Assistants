#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int val;
    int index;
} NumIndexPair;

int* countSmaller(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * numsSize);
    *returnSize = numsSize;
    for (int i = 0; i < numsSize; i++) {
        result[i] = 0;
    }

    NumIndexPair* arr = (NumIndexPair*)malloc(sizeof(NumIndexPair) * numsSize);
    for (int i = 0; i < numsSize; i++) {
        arr[i].val = nums[i];
        arr[i].index = i;
    }

    NumIndexPair* temp = (NumIndexPair*)malloc(sizeof(NumIndexPair) * numsSize);

    void mergeSort(NumIndexPair* arr, int left, int right) {
        if (left >= right) {
            return;
        }

        int mid = left + (right - left) / 2;
        mergeSort(arr, left, mid);
        mergeSort(arr, mid + 1, right);

        int i = left, j = mid + 1, k = left;
        while (i <= mid && j <= right) {
            if (arr[i].val <= arr[j].val) {
                temp[k] = arr[i];
                result[arr[i].index] += (j - (mid + 1));
                i++;
                k++;
            } else {
                temp[k] = arr[j];
                j++;
                k++;
            }
        }

        while (i <= mid) {
            temp[k] = arr[i];
            result[arr[i].index] += (j - (mid + 1));
            i++;
            k++;
        }

        while (j <= right) {
            temp[k] = arr[j];
            j++;
            k++;
        }

        for (i = left; i <= right; i++) {
            arr[i] = temp[i];
        }
    }

    mergeSort(arr, 0, numsSize - 1);

    free(arr);
    free(temp);

    return result;
}