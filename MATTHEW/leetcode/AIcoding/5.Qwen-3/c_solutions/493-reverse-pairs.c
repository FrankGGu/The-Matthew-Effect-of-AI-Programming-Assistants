#include <stdio.h>
#include <stdlib.h>

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

void merge(int* arr, int left, int mid, int right) {
    int i = left;
    int j = mid + 1;
    int k = left;
    int temp[right - left + 1];
    int count = 0;

    while (i <= mid && j <= right) {
        if (arr[i] <= 2 * arr[j]) {
            temp[k - left] = arr[i];
            i++;
        } else {
            count += mid - i + 1;
            temp[k - left] = arr[j];
            j++;
        }
        k++;
    }

    while (i <= mid) {
        temp[k - left] = arr[i];
        i++;
        k++;
    }

    while (j <= right) {
        temp[k - left] = arr[j];
        j++;
        k++;
    }

    for (i = left; i <= right; i++) {
        arr[i] = temp[i - left];
    }
}

void mergeSort(int* arr, int left, int right, int* count) {
    if (left < right) {
        int mid = left + (right - left) / 2;
        mergeSort(arr, left, mid, count);
        mergeSort(arr, mid + 1, right, count);
        merge(arr, left, mid, right);
    }
}

int reversePairs(int* nums, int numsSize) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    int count = 0;
    mergeSort(nums, 0, numsSize - 1, &count);
    free(temp);
    return count;
}