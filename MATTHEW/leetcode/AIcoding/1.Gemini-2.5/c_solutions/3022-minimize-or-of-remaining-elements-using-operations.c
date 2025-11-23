#include <stdbool.h>
#include <limits.h> // For INT_MAX, or use ~0 for all bits set

bool check(int target_or, int* nums, int numsSize, int k) {
    int num_segments = 0;
    int current_and_val = ~0; // Initialize with all bits set (equivalent to -1 for signed int)

    for (int i = 0; i < numsSize; ++i) {
        if (current_and_val == ~0) { // Starting a new segment
            current_and_val = nums[i];
        } else {
            current_and_val &= nums[i];
        }

        // If the current segment's bitwise AND value is less than or equal to target_or,
        // we can finalize this segment. We greedily finalize it to maximize the number
        // of segments, which in turn minimizes the number of operations.
        if (current_and_val <= target_or) {
            num_segments++;
            current_and_val = ~0; // Reset to start a new segment
        }
    }

    // After the loop, if current_and_val is not ~0, it means the last segment
    // (or the only segment if num_segments is 0) could not satisfy the condition
    // (its bitwise AND value was always greater than target_or).
    // In this case, it's impossible to achieve the target_or.
    if (current_and_val != ~0) {
        return false;
    }

    // If all segments were successfully formed and satisfied the AND condition,
    // check if the number of operations (numsSize - num_segments) is within k.
    return (numsSize - num_segments) <= k;
}

int minOrAfterOperations(int* nums, int numsSize, int k) {
    int low = 0;
    int high = 0;
    // The maximum possible OR value is the bitwise OR of all elements in the array.
    for (int i = 0; i < numsSize; ++i) {
        high |= nums[i];
    }

    int ans = high; // Initialize with a value that is definitely achievable (OR of all elements)

    // Perform binary search on the possible answer (the minimum OR value).
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (check(mid, nums, numsSize, k)) {
            ans = mid;         // mid is a possible answer, try for a smaller one
            high = mid - 1;
        } else {
            low = mid + 1;     // mid is not achievable, need a larger OR value
        }
    }

    return ans;
}