#include <stdlib.h>

long long mergeAndCountSplitInversions(int* nums, int left, int mid, int right, int* temp) {
    long long inversions = 0;
    int i = left;
    int j = mid + 1;
    int k = left;

    while (i <= mid && j <= right) {
        if (nums[i] <= nums[j]) {
            temp[k++] = nums[i++];
        } else {
            inversions += (mid - i + 1);
            temp[k++] = nums[j++];
        }
    }

    while (i <= mid) {
        temp[k++] = nums[i++];
    }

    while (j <= right) {
        temp[k++] = nums[j++];
    }

    for (i = left; i <= right; i++) {
        nums[i] = temp[i];
    }

    return inversions;
}

long long mergeSortAndCount(int* nums, int left, int right, int* temp) {
    long long inversions = 0;
    if (left < right) {
        int mid = left + (right - left) / 2;

        inversions += mergeSortAndCount(nums, left, mid, temp);
        inversions += mergeSortAndCount(nums, mid + 1, right, temp);
        inversions += mergeAndCountSplitInversions(nums, left, mid, right, temp);
    }
    return inversions;
}

int countInversions(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return 0;
    }

    int* temp = (int*)malloc(numsSize * sizeof(int));
    if (temp == NULL) {
        return -1;
    }

    long long totalInversions = mergeSortAndCount(nums, 0, numsSize - 1, temp);

    free(temp);

    return (int)totalInversions;
}