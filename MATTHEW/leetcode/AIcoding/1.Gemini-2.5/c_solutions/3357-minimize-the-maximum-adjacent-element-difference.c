#include <stdlib.h>
#include <stdbool.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool check(int diff, int* nums, int n, int p) {
    int count = 0;
    for (int i = 0; i < n - 1; ) {
        if (nums[i+1] - nums[i] <= diff) {
            count++;
            i += 2; // Form a pair, skip the next element as it's used
        } else {
            i += 1; // Cannot form a pair with current element, move to next
        }
    }
    return count >= p;
}

int minimizeMax(int* nums, int numsSize, int p) {
    // Sort the array first to easily find minimum differences between adjacent elements
    qsort(nums, numsSize, sizeof(int), compare);

    int low = 0;
    int high = nums[numsSize - 1] - nums[0]; // Maximum possible difference
    int ans = high; // Initialize with a worst-case large difference

    // Binary search for the minimum possible maximum difference
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (check(mid, nums, numsSize, p)) {
            ans = mid;         // mid is a possible answer, try for a smaller one
            high = mid - 1;
        } else {
            low = mid + 1;     // mid is too small, need a larger maximum difference
        }
    }

    return ans;
}