#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int merge(int* sum, int start, int mid, int end, int* temp, int target) {
    int i = start;
    int j = mid + 1;
    int k = start;
    int count = 0;

    while (i <= mid && j <= end) {
        if (sum[j] - sum[i] <= target) {
            count += mid - i + 1;
            j++;
        } else {
            i++;
        }
    }

    i = start;
    j = mid + 1;
    k = start;

    while (i <= mid && j <= end) {
        if (sum[i] <= sum[j]) {
            temp[k++] = sum[i++];
        } else {
            temp[k++] = sum[j++];
        }
    }

    while (i <= mid) {
        temp[k++] = sum[i++];
    }

    while (j <= end) {
        temp[k++] = sum[j++];
    }

    for (int m = start; m <= end; m++) {
        sum[m] = temp[m];
    }

    return count;
}

int mergeSort(int* sum, int start, int end, int* temp, int target) {
    if (start >= end) {
        return 0;
    }

    int mid = (start + end) / 2;
    int count = mergeSort(sum, start, mid, temp, target) + mergeSort(sum, mid + 1, end, temp, target);
    count += merge(sum, start, mid, end, temp, target);

    return count;
}

int countRangeSum(int* nums, int numsSize, int L, int R) {
    int n = numsSize;
    int* prefixSums = (int*)malloc((n + 1) * sizeof(int));
    prefixSums[0] = 0;

    for (int i = 0; i < n; i++) {
        prefixSums[i + 1] = prefixSums[i] + nums[i];
    }

    int* temp = (int*)malloc((n + 1) * sizeof(int));
    int result = mergeSort(prefixSums, 0, n, temp, R) - mergeSort(prefixSums, 0, n, temp, L - 1);

    free(prefixSums);
    free(temp);
    return result;
}