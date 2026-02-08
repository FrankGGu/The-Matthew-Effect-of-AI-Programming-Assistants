#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int comp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minAbsoluteDifference(int* nums, int numsSize, int x) {
    int minDiff = INT_MAX;
    int* sorted = (int*)malloc(sizeof(int) * numsSize);
    int sortedSize = 0;

    for (int i = x; i < numsSize; i++) {
        sorted[sortedSize++] = nums[i - x];
        qsort(sorted, sortedSize, sizeof(int), comp);

        int left = 0, right = sortedSize - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            int diff = abs(nums[i] - sorted[mid]);
            minDiff = (diff < minDiff) ? diff : minDiff;

            if (nums[i] == sorted[mid]) {
                break;
            } else if (nums[i] < sorted[mid]) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
    }

    free(sorted);
    return minDiff;
}