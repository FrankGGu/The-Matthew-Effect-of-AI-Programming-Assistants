#include <limits.h> // Required for INT_MAX

static inline int min(int a, int b) {
    return (a < b) ? a : b;
}

typedef struct {
    int or_val;
    int start_idx;
} OrEntry;

int shortestSubarrayWithOR(int* nums, int numsSize, int k) {
    int ans = INT_MAX;

    // We use two arrays to alternate between the current and previous sets of OR entries.
    // The maximum number of distinct OR values ending at any given index is bounded by
    // the number of bits in an integer (typically 32 for int, since nums[i] <= 10^9 < 2^30).
    // So, an array size of 32 is sufficient.
    OrEntry or_map_storage[2][32]; 
    int or_map_sizes[2] = {0, 0}; // Stores the current size of entries in each storage array
    int current_map_idx = 0;      // Index for the map being built for the current 'r'
    int prev_map_idx = 1;         // Index for the map from the previous 'r-1'

    for (int r = 0; r < numsSize; ++r) {
        // Swap indices to prepare for the next iteration.
        // The map that was 'current' becomes 'previous', and the other becomes 'current'.
        prev_map_idx = current_map_idx;
        current_map_idx = 1 - current_map_idx;

        OrEntry* prev_or_entries = or_map_storage[prev_map_idx];
        int prev_or_entries_size = or_map_sizes[prev_map_idx];

        OrEntry* current_or_entries = or_map_storage[current_map_idx];
        int current_or_entries_size = 0; // Reset size for the current map

        // 1. Add nums[r] itself as a new OR value starting at index 'r'.
        // If nums[r] is 0, and we already have a 0-OR value from a previous entry,
        // this will be handled by the subsequent loop's merging logic.
        // For now, we simply add it.
        current_or_entries[current_or_entries_size++] = (OrEntry){nums[r], r};

        // 2. Extend previous OR values by ORing with nums[r].
        for (int i = 0; i < prev_or_entries_size; ++i) {
            int prev_or = prev_or_entries[i].or_val;
            int prev_start_idx = prev_or_entries[i].start_idx;
            int new_or = prev_or | nums[r];

            // Check if this new_or value already exists in current_or_entries.
            // If it does, update its start_idx if the new one is smaller.
            // If not, add it as a new entry.
            int found = 0;
            for (int j = 0; j < current_or_entries_size; ++j) {
                if (current_or_entries[j].or_val == new_or) {
                    current_or_entries[j].start_idx = min(current_or_entries[j].start_idx, prev_start_idx);
                    found = 1;
                    break;
                }
            }
            if (!found) {
                current_or_entries[current_or_entries_size++] = (OrEntry){new_or, prev_start_idx};
            }
        }

        // Update the size for the current map
        or_map_sizes[current_map_idx] = current_or_entries_size;

        // 3. Check all OR values ending at 'r' to see if they meet the criteria (>= k).
        for (int i = 0; i < current_or_entries_size; ++i) {
            if (current_or_entries[i].or_val >= k) {
                // If an OR value meets 'k', calculate the length of the subarray
                // and update 'ans' with the minimum length found so far.
                ans = min(ans, r - current_or_entries[i].start_idx + 1);
            }
        }
    }

    // If 'ans' is still INT_MAX, no such subarray was found.
    return (ans == INT_MAX) ? -1 : ans;
}