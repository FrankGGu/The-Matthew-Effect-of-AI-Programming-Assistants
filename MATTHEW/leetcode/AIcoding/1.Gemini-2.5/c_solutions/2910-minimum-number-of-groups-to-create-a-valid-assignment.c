#include <stdlib.h> // For qsort
#include <stdbool.h> // For bool

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

bool check(long long x, int* counts_arr, int counts_size) {
    for (int i = 0; i < counts_size; ++i) {
        long long c = counts_arr[i];
        // Condition: floor(c/x) >= ceil(c/(x+1))
        // In integer arithmetic, ceil(A/B) for positive A, B is (A + B - 1) / B.
        // So, ceil(c/(x+1)) is (c + (x+1) - 1) / (x+1) which simplifies to (c + x) / (x+1).
        // The condition becomes: c/x >= (c + x) / (x+1)
        if (c / x < (c + x) / (x + 1)) {
            return false;
        }
    }
    return true;
}

int minimumGroupsForValidAssignment(int* nums, int numsSize) {
    // 1. Count frequencies of each number
    // Sort nums to easily count frequencies of consecutive identical elements.
    qsort(nums, numsSize, sizeof(int), compare);

    // Store unique counts in an array. Max number of unique counts is numsSize.
    int* counts_arr = (int*)malloc(numsSize * sizeof(int));
    int counts_size = 0;

    int current_val = nums[0];
    int current_count = 1;
    int min_overall_count = numsSize; // Initialize with maximum possible count

    for (int i = 1; i < numsSize; ++i) {
        if (nums[i] == current_val) {
            current_count++;
        } else {
            counts_arr[counts_size++] = current_count;
            if (current_count < min_overall_count) {
                min_overall_count = current_count;
            }
            current_val = nums[i];
            current_count = 1;
        }
    }
    // Add the last count after the loop
    counts_arr[counts_size++] = current_count;
    if (current_count < min_overall_count) {
        min_overall_count = current_count;
    }

    // 2. Binary search for the minimum possible x
    // The range for x is [1, min_overall_count].
    int low = 1;
    int high = min_overall_count;
    int ans = min_overall_count; // Default answer if x=min_overall_count works

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (check(mid, counts_arr, counts_size)) {
            ans = mid;
            high = mid - 1; // Try to find a smaller x
        } else {
            low = mid + 1; // x is too small, need a larger x
        }
    }

    free(counts_arr); // Free allocated memory
    return ans;
}