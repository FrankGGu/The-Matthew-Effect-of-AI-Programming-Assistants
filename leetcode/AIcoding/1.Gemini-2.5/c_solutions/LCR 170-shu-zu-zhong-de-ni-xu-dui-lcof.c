#include <stdlib.h>

int merge(int* nums, int low, int mid, int high) {
    int count = 0;
    int j = mid + 1;
    for (int i = low; i <= mid; i++) {
        while (j <= high && (long long)nums[i] > 2LL * nums[j]) {
            j++;
        }
        count += (j - (mid + 1));
    }

    int* temp = (int*)malloc((high - low + 1) * sizeof(int));
    int p1 = low, p2 = mid + 1, k = 0;

    while (p1 <= mid && p2 <= high) {
        if (nums[p1] <= nums[p2]) {
            temp[k++] = nums[p1++];
        } else {
            temp[k++] = nums[p2++];
        }
    }

    while (p1 <= mid) {
        temp[k++] = nums[p1++];
    }

    while (p2 <= high) {
        temp[k++] = nums[p2++];
    }

    for (k = 0; k <= high - low; k++) {
        nums[low + k] = temp[k];
    }

    free(temp);
    return count;
}

int mergeSort(int* nums, int low, int high) {
    if (low >= high) {
        return 0;
    }

    int mid = low + (high - low) / 2;
    int count = mergeSort(nums, low, mid);
    count += mergeSort(nums, mid + 1, high);
    count += merge(nums, low, mid, high);
    return count;
}

int reversePairs(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }
    return mergeSort(nums, 0, numsSize - 1);
}