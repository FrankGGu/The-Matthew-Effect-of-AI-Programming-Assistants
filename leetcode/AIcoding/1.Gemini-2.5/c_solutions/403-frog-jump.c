#include <stdbool.h>
#include <stdlib.h>

static int find_stone_idx(int* stones, int stonesSize, int target_pos) {
    int low = 0;
    int high = stonesSize - 1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (stones[mid] == target_pos) {
            return mid;
        } else if (stones[mid] < target_pos) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return -1; // Stone not found
}

bool canCross(int* stones, int stonesSize) {
    if (stones[1] != 1) {
        return false;
    }

    // dp[i][k] is true if the frog can reach the stone at index 'i' with a last jump of 'k' units.
    // The maximum possible jump length 'k' to consider is stonesSize.
    bool dp[stonesSize][stonesSize + 1];

    for (int i = 0; i < stonesSize; ++i) {
        for (int j = 0; j <= stonesSize; ++j) {
            dp[i][j] = false;
        }
    }

    // Initial state: The frog reaches the stone at index 1 (which must be at position 1)
    // with a jump of 1 unit.
    dp[1][1] = true;

    // Iterate through each stone from the second stone (index 1) up to the second-to-last stone.
    for (int i = 1; i < stonesSize; ++i) {
        // Iterate through all possible jump lengths 'k' that could have been used to reach stone 'i'.
        for (int k = 1; k <= stonesSize; ++k) {
            if (dp[i][k]) {
                // If stone 'i' can be reached with a jump of 'k',
                // consider the next possible jumps: k-1, k, k+1.
                for (int next_jump_diff = -1; next_jump_diff <= 1; ++next_jump_diff) {
                    int next_jump = k + next_jump_diff;

                    // Jump length must be positive
                    if (next_jump > 0) {
                        int target_pos = stones[i] + next_jump;
                        int target_idx = find_stone_idx(stones, stonesSize, target_pos);

                        // If a stone exists at target_pos, mark it as reachable
                        if (target_idx != -1) {
                            dp[target_idx][next_jump] = true;
                        }
                    }
                }
            }
        }
    }

    // After processing all possible jumps, check if the last stone (stonesSize - 1)
    // can be reached by any valid jump length.
    for (int k = 1; k <= stonesSize; ++k) {
        if (dp[stonesSize - 1][k]) {
            return true;
        }
    }

    return false;
}