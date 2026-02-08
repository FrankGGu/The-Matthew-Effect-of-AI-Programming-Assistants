#include <stdlib.h> // Required for qsort

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findPairs(int* nums, int numsSize, int k) {
    if (numsSize < 2 || k < 0) {
        return 0;
    }

    qsort(nums, numsSize, sizeof(int), compare);

    int count = 0;

    if (k == 0) {
        // For k=0, we need to count unique numbers that appear at least twice.
        for (int i = 0; i < numsSize - 1; ++i) {
            // If current number is equal to the next number, it's a duplicate.
            // We only count it if it's the first occurrence of this duplicate value
            // (i.e., it's different from the previous number, or it's the very first element).
            if (nums[i] == nums[i+1]) {
                if (i == 0 || nums[i] != nums[i-1]) {
                    count++;
                }
            }
        }
    } else { // k > 0
        // For k > 0, we use a two-pointer approach on the sorted array.
        int i = 0; // Left pointer
        int j = 1; // Right pointer

        while (i < numsSize && j < numsSize) {
            // Skip duplicate values for the left pointer 'i' to ensure unique pairs.
            if (i > 0 && nums[i] == nums[i-1]) {
                i++;
                continue;
            }

            // Ensure 'j' is always ahead of 'i'. If 'j' catches up or falls behind, advance it.
            // This can happen if 'i' advances past 'j' due to the 'diff > k' condition.
            if (j <= i) {
                j = i + 1;
                if (j >= numsSize) break; // If j goes out of bounds, no more pairs possible.
            }

            int diff = nums[j] - nums[i];

            if (diff == k) {
                // Found a pair (nums[i], nums[j])
                count++;
                i++; // Move both pointers to look for the next distinct pair
                j++;
            } else if (diff < k) {
                // The difference is too small, need a larger nums[j]
                j++;
            } else { // diff > k
                // The difference is too large, need a larger nums[i]
                i++;
            }
        }
    }

    return count;
}