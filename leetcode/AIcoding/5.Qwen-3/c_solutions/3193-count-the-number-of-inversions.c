#include <stdio.h>
#include <stdlib.h>

long long merge(int arr[], int temp[], int left, int mid, int right) {
    int i = left, j = mid, k = left;
    long long inv_count = 0;

    while (i < mid && j <= right) {
        if (arr[i] <= arr[j]) {
            temp[k++] = arr[i++];
        } else {
            temp[k++] = arr[j++];
            inv_count += mid - i;
        }
    }

    while (i < mid)
        temp[k++] = arr[i++];

    while (j <= right)
        temp[k++] = arr[j++];

    for (i = left; i <= right; i++)
        arr[i] = temp[i];

    return inv_count;
}

long long merge_sort(int arr[], int temp[], int left, int right) {
    long long inv_count = 0;
    if (left < right) {
        int mid = (left + right) / 2;
        inv_count += merge_sort(arr, temp, left, mid);
        inv_count += merge_sort(arr, temp, mid + 1, right);
        inv_count += merge(arr, temp, left, mid + 1, right);
    }
    return inv_count;
}

int countInversions(int* arr, int n) {
    int* temp = (int*)malloc(n * sizeof(int));
    long long result = merge_sort(arr, temp, 0, n - 1);
    free(temp);
    return (int)result;
}