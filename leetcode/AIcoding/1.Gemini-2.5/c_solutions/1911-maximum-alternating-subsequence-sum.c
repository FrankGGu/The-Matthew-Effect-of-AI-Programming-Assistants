#include <limits.h> // Required for LLONG_MAX

long long maxAlternatingSum(int* nums, int numsSize) {
    long long dp_plus = 0;          // Maximum alternating sum ending with an element being added.
                                    // Initialized to 0 to represent an empty subsequence, or the base for starting a new one.
    long long dp_minus = -LLONG_MAX; // Maximum alternating sum ending with an element being subtracted.
                                    // Initialized to a very small negative number as a subsequence cannot start with a subtraction.

    for (int i = 0; i < numsSize; i++) {
        long long num = nums[i];

        long long prev_dp_plus = dp_plus;
        long long prev_dp_minus = dp_minus;

        // Update dp_plus:
        // We consider three possibilities for the new dp_plus value:
        // 1. Keep the previous maximum sum ending with an addition (prev_dp_plus). This means we don't include 'num' as an added element.
        // 2. Start a new subsequence with 'num'. The sum is just 'num'.
        // 3. Extend a subsequence that ended with a subtraction (prev_dp_minus) by adding 'num'. The sum is 'prev_dp_minus + num'.
        long long candidate_dp_plus_1 = prev_dp_plus;
        long long candidate_dp_plus_2 = num;
        long long candidate_dp_plus_3 = prev_dp_minus + num;

        dp_plus = (candidate_dp_plus_1 > candidate_dp_plus_2 ? candidate_dp_plus_1 : candidate_dp_plus_2);
        dp_plus = (dp_plus > candidate_dp_plus_3 ? dp_plus : candidate_dp_plus_3);

        // Update dp_minus:
        // We consider two possibilities for the new dp_minus value:
        // 1. Keep the previous maximum sum ending with a subtraction (prev_dp_minus). This means we don't include 'num' as a subtracted element.
        // 2. Extend a subsequence that ended with an addition (prev_dp_plus) by subtracting 'num'. The sum is 'prev_dp_plus - num'.
        //    A subsequence cannot start with a subtraction, so there's no 'num' only option here.
        long long candidate_dp_minus_1 = prev_dp_minus;
        long long candidate_dp_minus_2 = prev_dp_plus - num;

        dp_minus = (candidate_dp_minus_1 > candidate_dp_minus_2 ? candidate_dp_minus_1 : candidate_dp_minus_2);
    }

    // The maximum alternating subsequence sum must end with an element being added to maximize the sum.
    // If it ended with a subtraction, say '... + X - Y', we could simply remove '-Y' to get '... + X',
    // which would be a larger or equal sum (since Y >= 1).
    // The only exception is if all numbers are negative and the best sum is 0 (empty subsequence),
    // which is covered by dp_plus's initialization.
    return dp_plus;
}