#include <stdbool.h>
#include <stddef.h> // For size_t

static int max(int a, int b) {
    return a > b ? a : b;
}

static bool check(int* stones, int stonesSize, int max_jump_dist) {
    if (stonesSize <= 1) {
        return true;
    }

    int f1_curr_idx = 0; // Current stone index for frog 1
    int f2_curr_idx = 0; // Current stone index for frog 2

    for (int i = 1; i < stonesSize; ++i) {
        bool f1_can_reach = (stones[i] - stones[f1_curr_idx] <= max_jump_dist);
        bool f2_can_reach = (stones[i] - stones[f2_curr_idx] <= max_jump_dist);

        if (f1_can_reach && f2_can_reach) {
            // Both frogs can reach stone i.
            // To ensure feasibility, we can choose either.
            // A simple choice is to always let frog 1 take it if both can.
            // The specific choice here doesn't affect the correctness of the check,
            // as long as one of them moves.
            f1_curr_idx = i;
        } else if (f1_can_reach) {
            // Only frog 1 can reach stone i
            f1_curr_idx = i;
        } else if (f2_can_reach) {
            // Only frog 2 can reach stone i
            f2_curr_idx = i;
        } else {
            // Neither frog can reach stone i from their current positions.
            // Thus, it's impossible to visit all stones with this max_jump_dist.
            return false;
        }
    }
    return true;
}

int frogJump(int* stones, int stonesSize) {
    if (stonesSize <= 1) {
        return 0;
    }

    // The minimum possible maximum jump distance can be 0 (if all stones are at the same position).
    // The maximum possible maximum jump distance is the distance from the first to the last stone.
    int low = 0;
    int high = stones[stonesSize - 1] - stones[0];
    int ans = high; // Initialize with a safe upper bound

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (check(stones, stonesSize, mid)) {
            // If it's possible with 'mid' as max jump, try for a smaller 'mid'
            ans = mid;
            high = mid - 1;
        } else {
            // If it's not possible, 'mid' is too small, need a larger max jump
            low = mid + 1;
        }
    }

    return ans;
}