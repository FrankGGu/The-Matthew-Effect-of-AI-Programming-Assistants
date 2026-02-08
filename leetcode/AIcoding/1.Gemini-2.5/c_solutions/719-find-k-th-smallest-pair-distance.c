#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long count_pairs(int* nums, int numsSize, int mid) {
    long long count = 0;
    int left = 0;
    for (int right = 0; right < numsSize; right++) {
        while (nums[right] - nums[left] > mid) {
            left++;
        }
        count += (right - left);
    }
    return count;
}

int smallestDistancePair(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);

    int low = 0;
    int high = nums[numsSize - 1] - nums[0];
    int ans = 0;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (count_pairs(nums, numsSize, mid) >= k) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
}