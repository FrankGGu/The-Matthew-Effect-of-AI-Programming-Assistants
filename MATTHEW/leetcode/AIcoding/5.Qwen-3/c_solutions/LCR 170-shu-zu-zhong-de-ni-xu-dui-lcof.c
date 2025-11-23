#include <stdio.h>
#include <stdlib.h>

int merge(int arr[], int temp[], int left, int mid, int right) {
    int i = left, j = mid, k = left;
    int count = 0;
    while (i < mid && j <= right) {
        if (arr[i] <= arr[j]) {
            temp[k++] = arr[i++];
        } else {
            temp[k++] = arr[j++];
            count += mid - i;
        }
    }
    while (i < mid) {
        temp[k++] = arr[i++];
    }
    while (j <= right) {
        temp[k++] = arr[j++];
    }
    for (i = left; i <= right; i++) {
        arr[i] = temp[i];
    }
    return count;
}

int mergeSort(int arr[], int temp[], int left, int right) {
    int mid, count = 0;
    if (left < right) {
        mid = (left + right) / 2;
        count += mergeSort(arr, temp, left, mid);
        count += mergeSort(arr, temp, mid + 1, right);
        count += merge(arr, temp, left, mid + 1, right);
    }
    return count;
}

int reversePairs(int* nums, int numsSize) {
    int* temp = (int*)malloc(numsSize * sizeof(int));
    int result = mergeSort(nums, temp, 0, numsSize - 1);
    free(temp);
    return result;
}