#include <stdlib.h> // Required for general utilities, though not strictly for this specific solution if max is custom implemented.

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long minOperations(int* nums, int numsSize, int* target, int targetSize) {
    long long total_operations = 0;
    // prev_positive_level tracks the net positive difference (nums[i] - target[i] > 0)
    // that is "active" or "carried over" from the previous index.
    long long prev_positive_level = 0; 
    // prev_negative_level tracks the net negative difference (nums[i] - target[i] < 0)
    // that is "active" or "carried over" from the previous index.
    long long prev_negative_level = 0; 

    for (int i = 0; i < numsSize; i++) {
        long long current_diff = (long long)nums[i] - target[i];

        if (current_diff > 0) {
            // If the current difference is positive, we need to decrease nums[i].
            // Any active negative operations from previous indices must terminate here.
            // We only need to add new operations if the current positive difference
            // exceeds the positive level carried from the previous index.
            total_operations += max(0LL, current_diff - prev_positive_level);
            prev_positive_level = current_diff; // Update positive level for next iteration
            prev_negative_level = 0;            // Reset negative level as it's no longer active
        } else if (current_diff < 0) {
            // If the current difference is negative, we need to increase nums[i].
            // Any active positive operations from previous indices must terminate here.
            // We only need to add new operations if the absolute current negative difference
            // exceeds the negative level carried from the previous index.
            total_operations += max(0LL, -current_diff - prev_negative_level);
            prev_negative_level = -current_diff; // Update negative level for next iteration (stored as positive value)
            prev_positive_level = 0;             // Reset positive level as it's no longer active
        } else { // current_diff == 0
            // If the current difference is zero, no net operations are needed at this index.
            // Any operations carried from previous indices must terminate here.
            prev_positive_level = 0;
            prev_negative_level = 0;
        }
    }

    return total_operations;
}