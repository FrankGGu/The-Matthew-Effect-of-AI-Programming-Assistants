#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int mergeSortAndCount(int arr[], int l, int r) {
    int inv_count = 0;
    if (l < r) {
        int m = (l + r) / 2;
        inv_count += mergeSortAndCount(arr, l, m);
        inv_count += mergeSortAndCount(arr, m + 1, r);
        inv_count += merge(arr, l, m, r);
    }
    return inv_count;
}

int merge(int arr[], int l, int m, int r) {
    int i, j, k;
    int n1 = m - l + 1;
    int n2 = r - m;

    int L[n1], R[n2];

    for (i = 0; i < n1; i++)
        L[i] = arr[l + i];
    for (j = 0; j < n2; j++)
        R[j] = arr[m + 1 + j];

    i = 0;
    j = 0;
    k = l;
    int inv_count = 0;

    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            arr[k++] = L[i++];
        } else {
            arr[k++] = R[j++];
            inv_count += (n1 - i);
        }
    }

    while (i < n1) {
        arr[k++] = L[i++];
    }

    while (j < n2) {
        arr[k++] = R[j++];
    }

    return inv_count;
}

int countInversions(int* arr, int n) {
    return mergeSortAndCount(arr, 0, n - 1);
}