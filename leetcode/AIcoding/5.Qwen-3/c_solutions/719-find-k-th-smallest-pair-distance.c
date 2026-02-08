#include <stdio.h>
#include <stdlib.h>

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int findKthSmallestPairDistance(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);

    int left = 0;
    int right = nums[numsSize - 1] - nums[0];

    while (left < right) {
        int mid = (left + right) / 2;
        int count = 0;
        int j = 0;

        for (int i = 0; i < numsSize; i++) {
            while (j < numsSize && nums[j] - nums[i] <= mid) {
                j++;
            }
            count += j - i - 1;
        }

        if (count < k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}