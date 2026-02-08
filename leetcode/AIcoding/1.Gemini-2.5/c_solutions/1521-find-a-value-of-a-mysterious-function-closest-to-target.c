#include <stdlib.h> // For abs

int findClosestNumber(int* arr, int arrSize, int target) {
    // Initialize min_diff with a very large value.
    // The maximum possible difference is around 10^9 (max target or max array element).
    // INT_MAX is approximately 2 * 10^9, so 2000000001 is a safe initial value.
    int min_diff = 2000000001; 

    // current_ands will store all unique bitwise AND results ending at the previous index (i-1).
    // The maximum number of distinct values for bitwise AND results for a fixed starting point
    // is at most 32 (for 32-bit integers), because each new AND operation can only
    // turn 1s into 0s, and there are at most 31 bits that can be turned off.
    // Plus one for the current element itself.
    int current_ands[32];
    int current_ands_count = 0; // Number of elements in current_ands

    for (int i = 0; i < arrSize; ++i) {
        // next_ands will store all unique bitwise AND results ending at the current index 'i'.
        int next_ands[32];
        int next_ands_count = 0;

        // The first value ending at index 'i' is arr[i] itself (f(i, i)).
        next_ands[next_ands_count++] = arr[i];

        // For each unique AND result 'val' that ended at (i-1) (i.e., f(k, i-1) for k < i),
        // calculate the new AND result ending at 'i': f(k, i) = f(k, i-1) & arr[i].
        for (int j = 0; j < current_ands_count; ++j) {
            int val = current_ands[j] & arr[i];

            // Check if this new 'val' is already in next_ands to maintain uniqueness.
            // Since next_ands_count is small (max 32), a linear search is efficient enough.
            int found = 0;
            for (int k = 0; k < next_ands_count; ++k) {
                if (next_ands[k] == val) {
                    found = 1;
                    break;
                }
            }
            if (!found) {
                next_ands[next_ands_count++] = val;
            }
        }

        // Update current_ands for the next iteration.
        // Copy the unique values from next_ands to current_ands.
        current_ands_count = 0;
        for (int j = 0; j < next_ands_count; ++j) {
            current_ands[current_ands_count++] = next_ands[j];
        }

        // After processing index 'i', current_ands now contains all unique f(k, i) values for k <= i.
        // Update min_diff with the absolute difference between these values and the target.
        for (int j = 0; j < current_ands_count; ++j) {
            int diff = abs(current_ands[j] - target);
            if (diff < min_diff) {
                min_diff = diff;
            }
        }
    }

    return min_diff;
}