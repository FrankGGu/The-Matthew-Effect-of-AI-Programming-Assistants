#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minAbsoluteSumDiff(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    int* sortedNums1 = (int*)malloc(nums1Size * sizeof(int));
    for (int i = 0; i < nums1Size; i++) {
        sortedNums1[i] = nums1[i];
    }
    qsort(sortedNums1, nums1Size, sizeof(int), compare);

    int minDiff = INT_MAX;
    for (int i = 0; i < nums1Size; i++) {
        int target = nums2[i];
        int left = 0, right = nums1Size - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (sortedNums1[mid] == target) {
                left = mid;
                break;
            } else if (sortedNums1[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        if (left < nums1Size) {
            minDiff = fmin(minDiff, abs(sortedNums1[left] - target));
        }
        if (left > 0) {
            minDiff = fmin(minDiff, abs(sortedNums1[left - 1] - target));
        }
    }

    free(sortedNums1);
    return minDiff;
}