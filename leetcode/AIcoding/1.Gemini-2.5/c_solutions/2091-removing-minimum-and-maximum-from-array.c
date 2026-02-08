#include <limits.h> // For INT_MAX, INT_MIN

static inline int min(int a, int b) {
    return a < b ? a : b;
}

static inline int max(int a, int b) {
    return a > b ? a : b;
}

int minimumDeletions(int* nums, int numsSize) {
    if (numsSize == 1) {
        return 1;
    }

    int min_val = INT_MAX;
    int max_val = INT_MIN;
    int min_idx = -1;
    int max_idx = -1;

    // Find the minimum and maximum values and their indices
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < min_val) {
            min_val = nums[i];
            min_idx = i;
        }
        if (nums[i] > max_val) {
            max_val = nums[i];
            max_idx = i;
        }
    }

    // Ensure idx_left is the smaller of the two indices and idx_right is the larger
    int idx_left = min(min_idx, max_idx);
    int idx_right = max(min_idx, max_idx);

    // Option 1: Remove both elements by deleting from the left side
    // This involves deleting all elements from index 0 up to idx_right (inclusive).
    // The number of deletions is (idx_right - 0 + 1) = idx_right + 1.
    int deletions_from_left = idx_right + 1;

    // Option 2: Remove both elements by deleting from the right side
    // This involves deleting all elements from index idx_left (inclusive) up to numsSize - 1.
    // The number of deletions is (numsSize - 1 - idx_left + 1) = numsSize - idx_left.
    int deletions_from_right = numsSize - idx_left;

    // Option 3: Remove one element from the left side and the other from the right side
    // This involves deleting elements from index 0 up to idx_left (inclusive)
    // AND deleting elements from index idx_right (inclusive) up to numsSize - 1.
    // Number of deletions from left: (idx_left + 1)
    // Number of deletions from right: (numsSize - idx_right)
    int deletions_from_both_sides = (idx_left + 1) + (numsSize - idx_right);

    // The minimum number of deletions is the smallest of the three options
    return min(min(deletions_from_left, deletions_from_right), deletions_from_both_sides);
}