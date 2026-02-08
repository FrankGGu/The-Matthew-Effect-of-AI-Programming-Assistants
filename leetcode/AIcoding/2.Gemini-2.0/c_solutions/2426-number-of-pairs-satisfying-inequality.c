#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int merge(int* diff, int low, int mid, int high, int d) {
    int count = 0;
    int j = mid + 1;
    for (int i = low; i <= mid; i++) {
        while (j <= high && diff[i] > (long long)diff[j] + d) {
            j++;
        }
        count += (high - j + 1);
    }

    int* temp = (int*)malloc(sizeof(int) * (high - low + 1));
    int i = low;
    j = mid + 1;
    int k = 0;
    while (i <= mid && j <= high) {
        if (diff[i] <= diff[j]) {
            temp[k++] = diff[i++];
        } else {
            temp[k++] = diff[j++];
        }
    }

    while (i <= mid) {
        temp[k++] = diff[i++];
    }

    while (j <= high) {
        temp[k++] = diff[j++];
    }

    for (i = low; i <= high; i++) {
        diff[i] = temp[i - low];
    }

    free(temp);
    return count;
}

int mergeSort(int* diff, int low, int high, int d) {
    if (low >= high) {
        return 0;
    }

    int mid = low + (high - low) / 2;
    int count = mergeSort(diff, low, mid, d) + mergeSort(diff, mid + 1, high, d);
    count += merge(diff, low, mid, high, d);
    return count;
}

long long numberOfPairs(int* nums1, int nums1Size, int* nums2, int nums2Size, int diff) {
    int* diffArr = (int*)malloc(sizeof(int) * nums1Size);
    for (int i = 0; i < nums1Size; i++) {
        diffArr[i] = nums1[i] - nums2[i];
    }

    long long result = mergeSort(diffArr, 0, nums1Size - 1, diff);
    free(diffArr);
    return result;
}