#include <limits.h> // For LLONG_MIN

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long maximizeTotalCost(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0;
    }

    // dp_start: max cost ending with current element as the start of a new subarray.
    //           The cost of the current element is +nums[i].
    // dp_add: max cost ending with current element extending a subarray and being added.
    //         This implies the previous element in the same subarray was subtracted.
    //         The cost of the current element is +nums[i].
    // dp_sub: max cost ending with current element extending a subarray and being subtracted.
    //         This implies the previous element in the same subarray was added or started.
    //         The cost of the current element is -nums[i].

    // Initialize for the first element (nums[0])
    long long dp_start = nums[0];
    long long dp_add = LLONG_MIN; // First element cannot be an 'added' extension
    long long dp_sub = LLONG_MIN; // First element cannot be a 'subtracted' extension

    // Iterate from the second element
    for (int i = 1; i < numsSize; ++i) {
        long long current_val = nums[i];

        // Calculate new_dp_start for nums[i]
        // If nums[i] starts a new subarray, it means the subarray ending at nums[i-1] is complete.
        // We take the maximum cost from any state at nums[i-1] and add nums[i].
        long long max_prev_overall = dp_start;
        if (dp_add != LLONG_MIN) {
            max_prev_overall = max(max_prev_overall, dp_add);
        }
        if (dp_sub != LLONG_MIN) {
            max_prev_overall = max(max_prev_overall, dp_sub);
        }
        long long new_dp_start = max_prev_overall + current_val;

        // Calculate new_dp_add for nums[i]
        // If nums[i] is added, it must extend a subarray where nums[i-1] was subtracted.
        long long new_dp_add;
        if (dp_sub == LLONG_MIN) {
            new_dp_add = LLONG_MIN; // No valid path to reach this state
        } else {
            new_dp_add = dp_sub + current_val;
        }

        // Calculate new_dp_sub for nums[i]
        // If nums[i] is subtracted, it must extend a subarray where nums[i-1] was added or started.
        long long new_dp_sub;
        long long max_prev_for_sub = dp_start; // Previous could have started a subarray
        if (dp_add != LLONG_MIN) {
            max_prev_for_sub = max(max_prev_for_sub, dp_add); // Previous could have been added
        }
        // dp_start is initialized with nums[0] (which is >= 1), so max_prev_for_sub will always be a valid number, not LLONG_MIN.
        new_dp_sub = max_prev_for_sub - current_val;

        // Update states for the next iteration
        dp_start = new_dp_start;
        dp_add = new_dp_add;
        dp_sub = new_dp_sub;
    }

    // The final answer is the maximum of the three possible states for the last element (nums[numsSize-1])
    long long result = dp_start;
    if (dp_add != LLONG_MIN) {
        result = max(result, dp_add);
    }
    if (dp_sub != LLONG_MIN) {
        result = max(result, dp_sub);
    }

    return result;
}