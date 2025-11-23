#include <stddef.h> // For size_t, though not strictly needed here

typedef struct {
    int val;
    int count;
} AndCount;

long long countSubarrays(int* nums, int numsSize, int k) {
    long long total_count = 0;

    // prev_ands stores (AND_value, count) pairs for all subarrays ending at r-1.
    // current_ands stores (AND_value, count) pairs for all subarrays ending at r.
    // The maximum number of distinct AND values for subarrays ending at any point
    // is at most 30 (since numbers are up to 10^9, which is < 2^30).
    // We use a fixed-size array and track the actual number of elements.
    AndCount prev_ands[32]; 
    int prev_ands_size = 0;

    AndCount current_ands[32];
    int current_ands_size = 0;

    for (int r = 0; r < numsSize; ++r) {
        // Reset current_ands for the new 'r'
        current_ands_size = 0; 

        // 1. Add the single element subarray [r, r]
        // Check if nums[r] itself equals k
        if (nums[r] == k) {
            total_count++;
        }
        // Add nums[r] to current_ands. Its count is 1.
        current_ands[current_ands_size++] = (AndCount){nums[r], 1};

        // 2. Extend previous subarrays by ANDing with nums[r]
        for (int i = 0; i < prev_ands_size; ++i) {
            int old_and_val = prev_ands[i].val;
            int old_count = prev_ands[i].count;

            int new_and_val = old_and_val & nums[r];

            // If the new AND value equals k, add its count to total
            if (new_and_val == k) {
                total_count += old_count;
            }

            // Add the new (AND_value, count) pair to current_ands.
            // This might create duplicate 'val' entries in current_ands, which will be merged later.
            current_ands[current_ands_size++] = (AndCount){new_and_val, old_count};
        }

        // 3. Merge duplicate 'val' entries in current_ands
        // Since the number of distinct values is small (max ~30),
        // a quadratic merge (iterating and searching) is efficient enough.
        AndCount merged_ands[32];
        int merged_ands_size = 0;

        for (int i = 0; i < current_ands_size; ++i) {
            int val = current_ands[i].val;
            int count = current_ands[i].count;

            // Check if 'val' already exists in merged_ands
            int found_idx = -1;
            for (int j = 0; j < merged_ands_size; ++j) {
                if (merged_ands[j].val == val) {
                    found_idx = j;
                    break;
                }
            }

            if (found_idx != -1) {
                // If found, add count to existing entry
                merged_ands[found_idx].count += count;
            } else {
                // If not found, add as a new entry
                merged_ands[merged_ands_size++] = (AndCount){val, count};
            }
        }

        // 4. Prepare for the next iteration: current_ands becomes prev_ands
        for (int i = 0; i < merged_ands_size; ++i) {
            prev_ands[i] = merged_ands[i];
        }
        prev_ands_size = merged_ands_size;
    }

    return total_count;
}