#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int min(int a, int b) {
    return a < b ? a : b;
}

int minNumberOfSemesters(int n, int** relations, int relationsSize, int* relationsColSize, int k) {
    // dp[mask] stores the minimum semesters to complete courses represented by mask
    // A mask is a bitmask where the i-th bit is set if course i is completed.
    int dp[1 << n];
    for (int i = 0; i < (1 << n); ++i) {
        dp[i] = INT_MAX;
    }
    dp[0] = 0; // 0 semesters to complete 0 courses

    // prereq[i] stores a bitmask of courses that must be completed before course i.
    // Courses are 0-indexed internally (0 to n-1).
    int prereq[n];
    for (int i = 0; i < n; ++i) {
        prereq[i] = 0;
    }

    // Populate the prereq array based on the given relations
    for (int i = 0; i < relationsSize; ++i) {
        int prevCourse = relations[i][0] - 1; // Convert to 0-indexed
        int nextCourse = relations[i][1] - 1; // Convert to 0-indexed
        prereq[nextCourse] |= (1 << prevCourse);
    }

    // Iterate through all possible masks (states of completed courses)
    // from 0 (no courses completed) up to (1 << n) - 1 (all courses completed).
    for (int mask = 0; mask < (1 << n); ++mask) {
        if (dp[mask] == INT_MAX) {
            continue; // This state is unreachable, so skip it
        }

        // Determine which courses are available to take in the next semester.
        // A course 'j' is available if:
        // 1. It's not yet taken (its bit is not set in 'mask').
        // 2. All its prerequisites are already taken (all bits in prereq[j] are set in 'mask').
        int can_take_mask = 0;
        for (int j = 0; j < n; ++j) {
            if (!((mask >> j) & 1)) { // If course j is not in the current mask
                // Check if all prerequisites for course j are satisfied (i.e., are in 'mask')
                if ((prereq[j] & mask) == prereq[j]) {
                    can_take_mask |= (1 << j); // Add course j to the set of available courses
                }
            }
        }

        // Iterate through all non-empty subsets of 'can_take_mask'.
        // Each 'take_mask' represents a set of courses chosen to be taken in the current semester.
        // The loop `for (int sub = S; sub > 0; sub = (sub - 1) & S)` efficiently iterates through all non-empty subsets of S.
        for (int take_mask = can_take_mask; take_mask > 0; take_mask = (take_mask - 1) & can_take_mask) {
            // Check if the number of courses in 'take_mask' is within the limit 'k'.
            // __builtin_popcount is a GCC extension for counting set bits, commonly available on LeetCode.
            if (__builtin_popcount(take_mask) <= k) {
                // Update the minimum semesters for the new state (current mask + courses taken this semester).
                // The new state is 'mask | take_mask'.
                dp[mask | take_mask] = min(dp[mask | take_mask], dp[mask] + 1);
            }
        }
    }

    // The result is the minimum semesters to complete all 'n' courses,
    // which corresponds to the mask where all bits from 0 to n-1 are set: (1 << n) - 1.
    return dp[(1 << n) - 1];
}