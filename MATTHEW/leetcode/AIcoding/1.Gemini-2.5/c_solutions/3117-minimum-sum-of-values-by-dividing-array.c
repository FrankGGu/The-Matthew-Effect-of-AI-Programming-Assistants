#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <string.h> // For memcpy

#define INF (LLONG_MAX / 2)

struct AndMinDp {
    int and_val;
    long long min_dp_val;
};

int compareAndMinDp(const void* a, const void* b) {
    return ((struct AndMinDp*)a)->and_val - ((struct AndMinDp*)b)->and_val;
}

long long min(long long a, long long b) {
    return a < b ? a : b;
}

long long minimumSum(int* nums, int numsSize, int* andValues, int andValuesSize, int k) {
    long long* dp_prev = (long long*)malloc((numsSize + 1) * sizeof(long long));
    long long* dp_current = (long long*)malloc((numsSize + 1) * sizeof(long long));

    for (int i = 0; i <= numsSize; ++i) {
        dp_prev[i] = INF;
    }
    dp_prev[0] = 0; // Base case: 0 segments, 0 length prefix, sum 0

    for (int j = 1; j <= k; ++j) {
        for (int i = 0; i <= numsSize; ++i) {
            dp_current[i] = INF;
        }

        // This array stores {and_val, min_dp_prev_val} for segments ending at `i-2`.
        // It's effectively the `current_min_dp_values` from the previous iteration of `i`.
        struct AndMinDp current_min_dp_values[32]; // Max ~31 distinct AND values
        int current_min_dp_values_count = 0;

        for (int i = 1; i <= numsSize; ++i) { // i is the length of prefix nums[0...i-1]
            // nums[i-1] is the current element being considered as the end of a segment.

            struct AndMinDp next_min_dp_values_temp[64]; // Temporary to collect all candidates before sorting/merging
            int next_min_dp_values_temp_count = 0;

            // Case 1: The current segment is just `nums[i-1]`.
            // It starts at `i-1`. The previous `j-1` segments must cover `nums[0...i-2]`.
            // So we need `dp_prev[i-1]`.
            if (dp_prev[i-1] != INF) {
                next_min_dp_values_temp[next_min_dp_values_temp_count++] = (struct AndMinDp){nums[i-1], dp_prev[i-1]};
            }

            // Case 2: Extend segments that ended at `i-2`.
            // `current_min_dp_values` holds `(and_val, min_dp_prev_p)` for segments ending at `i-2`.
            // When extending to `i-1`, the `p` (start index of the previous segments) remains the same.
            for (int k_int = 0; k_int < current_min_dp_values_count; ++k_int) {
                int prev_and_val = current_min_dp_values[k_int].and_val;
                long long prev_min_dp_val = current_min_dp_values[k_int].min_dp_val;

                int new_and_val = prev_and_val & nums[i-1];

                next_min_dp_values_temp[next_min_dp_values_temp_count++] = (struct AndMinDp){new_and_val, prev_min_dp_val};
            }

            // Sort `next_min_dp_values_temp` by `and_val` to merge duplicates.
            qsort(next_min_dp_values_temp, next_min_dp_values_temp_count, sizeof(struct AndMinDp), compareAndMinDp);

            // Merge duplicates:
            struct AndMinDp merged_min_dp_values[32];
            int merged_min_dp_values_count = 0;
            if (next_min_dp_values_temp_count > 0) {
                merged_min_dp_values[0] = next_min_dp_values_temp[0];
                merged_min_dp_values_count = 1;
                for (int k_int = 1; k_int < next_min_dp_values_temp_count; ++k_int) {
                    if (next_min_dp_values_temp[k_int].and_val == merged_min_dp_values[merged_min_dp_values_count - 1].and_val) {
                        merged_min_dp_values[merged_min_dp_values_count - 1].min_dp_val = min(merged_min_dp_values[merged_min_dp_values_count - 1].min_dp_val, next_min_dp_values_temp[k_int].min_dp_val);
                    } else {
                        merged_min_dp_values[merged_min_dp_values_count++] = next_min_dp_values_temp[k_int];
                    }
                }
            }

            // Update `current_min_dp_values` for the next iteration of `i`.
            memcpy(current_min_dp_values, merged_min_dp_values, merged_min_dp_values_count * sizeof(struct AndMinDp));
            current_min_dp_values_count = merged_min_dp_values_count;

            // Now, `merged_min_dp_values` contains `(and_value, min_dp_prev_val)` for segments ending at `i-1`.
            // Use these to update `dp_current[i]`.
            for (int k_int = 0; k_int < merged_min_dp_values_count; ++k_int) {
                int current_segment_and_val = merged_min_dp_values[k_int].and_val;
                long long min_prev_dp_val = merged_min_dp_values[k_int].min_dp_val;

                if (current_segment_and_val == andValues[j-1]) {
                    if (min_prev_dp_val != INF) {
                        dp_current[i] = min(dp_current[i], min_prev_dp_val + nums[i-1]);
                    }
                }
            }
        }

        // After iterating `i` for current `j`, `dp_current` is complete.
        // Prepare `dp_prev` for the next iteration of `j`.
        memcpy(dp_prev, dp_current, (numsSize + 1) * sizeof(long long));
    }

    long long result = dp_prev[numsSize];

    free(dp_prev);
    free(dp_current);

    if (result == INF) {
        return -1;
    }
    return result;
}