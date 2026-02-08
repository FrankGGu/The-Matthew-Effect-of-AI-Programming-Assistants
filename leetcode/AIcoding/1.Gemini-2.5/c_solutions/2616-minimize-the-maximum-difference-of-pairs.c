#include <stdlib.h> // Required for qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int check(int diff, int* nums, int n, int p) {
    int count = 0;
    for (int i = 0; i < n - 1; ) {
        if (nums[i+1] - nums[i] <= diff) {
            count++;
            i += 2; // Form a pair, skip both elements
        } else {
            i += 1; // Cannot form a pair with current element, move to the next
        }
        if (count >= p) {
            return 1; // Enough pairs found
        }
    }
    return count >= p;
}

int minimizeMax(int* nums, int numsSize, int p) {
    if (p == 0) {
        return 0; // If no pairs are required, the maximum difference is 0.
    }

    // Sort the array to easily find minimum differences
    qsort(nums, numsSize, sizeof(int), compare);

    int low = 0;
    int high = nums[numsSize - 1] - nums[0]; // Maximum possible difference
    int ans = high; // Initialize with a worst-case answer

    // Binary search for the minimum possible maximum difference
    while (low <= high) {
        int mid = low + (high - low) / 2; // Calculate mid to avoid overflow

        if (check(mid, nums, numsSize, p)) {
            ans = mid; // 'mid' is a possible maximum difference, try for a smaller one
            high = mid - 1;
        } else {
            low = mid + 1; // 'mid' is too small, need a larger maximum difference
        }
    }

    return ans;
}