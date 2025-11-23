#include <stdlib.h>
#include <limits.h>

int min(int a, int b) {
    return (a < b) ? a : b;
}

int closestToTarget(int* nums, int numsSize, int k) {
    int ans = INT_MAX;

    // prev_ors stores distinct OR values of subarrays ending at j-1
    // An integer has at most 31 bits (for positive values). The OR sum can change at most 31 times.
    // So, at most 32 distinct values can be generated for subarrays ending at a specific index.
    int prev_ors[32]; 
    int prev_ors_count = 0;

    for (int j = 0; j < numsSize; ++j) {
        int curr_num = nums[j];
        // curr_ors will store distinct OR values of subarrays ending at j
        int curr_ors[32]; 
        int curr_ors_count = 0;

        // The subarray [j, j] has OR sum nums[j]
        curr_ors[curr_ors_count++] = curr_num;
        ans = min(ans, abs(curr_num - k));

        // For each OR sum `val` that ended at `j-1`, `val | nums[j]` is an OR sum ending at `j`
        for (int i = 0; i < prev_ors_count; ++i) {
            int new_or_val = prev_ors[i] | curr_num;

            // Check if this new_or_val is already in curr_ors to maintain uniqueness
            int found = 0;
            for (int l = 0; l < curr_ors_count; ++l) {
                if (curr_ors[l] == new_or_val) {
                    found = 1;
                    break;
                }
            }
            if (!found) {
                curr_ors[curr_ors_count++] = new_or_val;
                ans = min(ans, abs(new_or_val - k));
            }
        }

        // Update prev_ors for the next iteration by copying curr_ors
        for (int i = 0; i < curr_ors_count; ++i) {
            prev_ors[i] = curr_ors[i];
        }
        prev_ors_count = curr_ors_count;
    }

    return ans;
}