#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

int countPairs(int *nums, int numsSize, int mid) {
    int count = 0;
    int j = 0;
    for (int i = 0; i < numsSize; i++) {
        while (j < numsSize && nums[j] - nums[i] <= mid) {
            j++;
        }
        count += j - i - 1;
    }
    return count;
}

int smallestDistancePair(int *nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), cmp);
    int low = 0;
    int high = nums[numsSize - 1] - nums[0];
    int ans = 0;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (countPairs(nums, numsSize, mid) >= k) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}