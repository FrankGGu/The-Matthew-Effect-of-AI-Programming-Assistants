#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int canChoosePairs(int* nums, int numsSize, int p, int mid) {
    int count = 0;
    for (int i = 0; i < numsSize - 1 && count < p; i++) {
        if (nums[i + 1] - nums[i] <= mid) {
            count++;
            i++;
        }
    }
    return count >= p;
}

int minimizeMax(int* nums, int numsSize, int p) {
    qsort(nums, numsSize, sizeof(int), compare);
    int left = 0, right = nums[numsSize - 1] - nums[0];
    int result = right;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (canChoosePairs(nums, numsSize, p, mid)) {
            result = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return result;
}