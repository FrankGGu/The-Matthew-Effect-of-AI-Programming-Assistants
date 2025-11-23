#include <stdlib.h> // For qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int lower_bound(int* arr, int low, int high, long long target) {
    int ans = high + 1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if ((long long)arr[mid] >= target) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

int upper_bound(int* arr, int low, int high, long long target) {
    int ans = high + 1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if ((long long)arr[mid] > target) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

long long countFairPairs(int* nums, int numsSize, int lower, int upper) {
    qsort(nums, numsSize, sizeof(int), compare);

    long long count = 0;
    for (int i = 0; i < numsSize; ++i) {
        long long target_lower_bound = (long long)lower - nums[i];
        long long target_upper_bound = (long long)upper - nums[i];

        // Search for j in the subarray nums[i+1 ... numsSize-1]
        int idx1 = lower_bound(nums, i + 1, numsSize - 1, target_lower_bound);
        int idx2 = upper_bound(nums, i + 1, numsSize - 1, target_upper_bound);

        count += (long long)(idx2 - idx1);
    }
    return count;
}