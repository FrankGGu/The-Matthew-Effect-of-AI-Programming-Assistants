#include <stdlib.h>
#include <string.h>

int merge(int* nums, int left, int mid, int right) {
    int count = 0;
    int j = mid + 1;
    for (int i = left; i <= mid; i++) {
        while (j <= right && (long long)nums[i] > 2LL * nums[j]) {
            j++;
        }
        count += (j - (mid + 1));
    }

    int* temp = (int*)malloc((right - left + 1) * sizeof(int));
    int i = left;
    j = mid + 1;
    int k = 0;

    while (i <= mid && j <= right) {
        if (nums[i] <= nums[j]) {
            temp[k++] = nums[i++];
        } else {
            temp[k++] = nums[j++];
        }
    }

    while (i <= mid) {
        temp[k++] = nums[i++];
    }

    while (j <= right) {
        temp[k++] = nums[j++];
    }

    for (int l = 0; l < k; l++) {
        nums[left + l] = temp[l];
    }
    free(temp);
    return count;
}

int mergeSort(int* nums, int left, int right) {
    if (left >= right) {
        return 0;
    }

    int mid = left + (right - left) / 2;
    int count = mergeSort(nums, left, mid);
    count += mergeSort(nums, mid + 1, right);
    count += merge(nums, left, mid, right);
    return count;
}

int reversePairs(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }
    return mergeSort(nums, 0, numsSize - 1);
}