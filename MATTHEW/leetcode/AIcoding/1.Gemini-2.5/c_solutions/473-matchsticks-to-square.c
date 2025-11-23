#include <stdbool.h>
#include <stdlib.h> // For qsort

int compareDescending(const void* a, const void* b) {
    return (*(int*)b - *(int*)a);
}

bool backtrack(int idx, int* matchsticks, int matchsticksSize, long long* sides, long long targetSide) {
    // Base case: All matchsticks have been successfully placed
    if (idx == matchsticksSize) {
        // If all sticks are placed, and all side sums were kept <= targetSide,
        // then all sides must sum exactly to targetSide due to the totalSum check.
        return true;
    }

    // Try to place the current matchstick into one of the four sides
    for (int i = 0; i < 4; i++) {
        // Check if the current matchstick can fit into the current side
        if (sides[i] + matchsticks[idx] <= targetSide) {
            sides[i] += matchsticks[idx]; // Place the matchstick

            // Recursively try to place the next matchstick
            if (backtrack(idx + 1, matchsticks, matchsticksSize, sides, targetSide)) {
                return true; // Found a solution
            }

            sides[i] -= matchsticks[idx]; // Backtrack: remove the matchstick

            // Pruning:
            // 1. If we tried to place matchsticks[idx] into an empty side (sides[i] == 0 after backtracking),
            //    and it didn't lead to a solution, then trying other empty sides for this matchstick
            //    would be symmetrical and also fail. So, we can stop trying other sides for the current matchstick.
            // 2. If we filled a side exactly to targetSide with matchsticks[idx] (sides[i] == targetSide after backtracking),
            //    and it didn't lead to a solution, then trying to fill other sides exactly to targetSide
            //    with this matchstick (and other sticks) would also be symmetrical and fail.
            //    So, we can stop trying other sides for the current matchstick.
            if (sides[i] == 0 || sides[i] == targetSide) {
                break; // Stop trying other sides for the current matchstick
            }
        }
    }
    return false; // No side could accommodate the current matchstick
}

bool makesquare(int* matchsticks, int matchsticksSize) {
    // A square needs at least 4 matchsticks
    if (matchsticksSize < 4) {
        return false;
    }

    long long totalSum = 0;
    for (int i = 0; i < matchsticksSize; i++) {
        totalSum += matchsticks[i];
    }

    // If the total sum is not divisible by 4, it's impossible to form 4 equal sides
    if (totalSum % 4 != 0) {
        return false;
    }

    long long targetSide = totalSum / 4;

    // Sort matchsticks in descending order. This helps prune the search space faster
    // by trying larger, more restrictive sticks first.
    qsort(matchsticks, matchsticksSize, sizeof(int), compareDescending);

    // If the largest matchstick is greater than the target side length, it's impossible
    // (matchsticks[0] is the largest because of sorting)
    if (matchsticks[0] > targetSide) {
        return false;
    }

    // Initialize the four sides with current lengths of 0
    long long sides[4] = {0, 0, 0, 0};

    // Start the backtracking process from the first matchstick (index 0)
    return backtrack(0, matchsticks, matchsticksSize, sides, targetSide);
}