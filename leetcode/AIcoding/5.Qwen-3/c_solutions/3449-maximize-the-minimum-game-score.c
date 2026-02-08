#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minimizeMax(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);

    int left = 0;
    int right = nums[numsSize - 1] - nums[0];

    while (left < right) {
        int mid = (left + right) / 2;
        int count = 0;
        int i = 0;

        while (i < numsSize - 1) {
            if (nums[i + 1] - nums[i] > mid) {
                count++;
                i++;
            } else {
                i += 2;
            }
        }

        if (count <= k) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}