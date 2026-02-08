#include <stdlib.h> // For malloc, free

static inline int max(int a, int b) {
    return a > b ? a : b;
}

int maximumNumberOfMovesToKillAllPawns(int* nums, int numsSize, int k) {
    // Collect indices of pawns (where nums[i] == 1)
    // Using a dynamically allocated array to store pawn indices
    int* pawn_indices = (int*)malloc(numsSize * sizeof(int));
    // In a real-world scenario, check for malloc failure.
    // For LeetCode, it's often assumed malloc succeeds for reasonable sizes.

    int pawn_count = 0;
    for (int i = 0; i < numsSize; ++i) {
        if (nums[i] == 1) {
            pawn_indices[pawn_count++] = i;
        }
    }

    // If there are no pawns, no pawns can be killed.
    if (pawn_count == 0) {
        free(pawn_indices);
        return 0;
    }

    int max_killed_pawns = 0;
    int left = 0; // Left pointer for the sliding window of pawns

    // Iterate with the right pointer to expand the window
    for (int right = 0; right < pawn_count; ++right) {
        long long current_pawn_left_idx = pawn_indices[left];
        long long current_pawn_right_idx = pawn_indices[right];

        // Calculate the minimum moves required to kill all pawns in the current window [pawn_indices[left], pawn_indices[right]]
        // starting from position 0.
        // This cost assumes one turn is allowed: go right to current_pawn_right_idx, then turn and go left to current_pawn_left_idx.
        // Total moves = (current_pawn_right_idx - 0) + (current_pawn_right_idx - current_pawn_left_idx)
        //             = 2 * current_pawn_right_idx - current_pawn_left_idx
        long long cost = 2 * current_pawn_right_idx - current_pawn_left_idx;

        // Shrink the window from the left if the current cost exceeds k
        while (cost > k && left <= right) {
            left++;
            // If the left pointer crosses the right pointer, the window is empty or invalid
            if (left > right) {
                break;
            }
            current_pawn_left_idx = pawn_indices[left];
            cost = 2 * current_pawn_right_idx - current_pawn_left_idx;
        }

        // If a valid window exists (left <= right), update the maximum number of killed pawns
        if (left <= right) {
            max_killed_pawns = max(max_killed_pawns, right - left + 1);
        }
    }

    // Free the dynamically allocated memory
    free(pawn_indices);
    return max_killed_pawns;
}