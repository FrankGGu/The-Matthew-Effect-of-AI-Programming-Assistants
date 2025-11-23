import java.util.Arrays;

class Solution {
    public int minNumberOfSemesters(int n, int[][] relations, int k) {
        // prereq[i] stores a bitmask where the j-th bit is set if course j is a prerequisite for course i.
        int[] prereq = new int[n];
        for (int[] relation : relations) {
            // Convert to 0-indexed
            int prevCourse = relation[0] - 1;
            int nextCourse = relation[1] - 1;
            prereq[nextCourse] |= (1 << prevCourse);
        }

        // dp[mask] stores the minimum number of semesters to complete courses represented by 'mask'.
        // mask is a bitmask where the i-th bit is set if course i is completed.
        int[] dp = new int[1 << n];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0; // 0 semesters to complete 0 courses.

        // Iterate through all possible states (masks) of completed courses.
        // A mask represents a set of courses that have been completed.
        for (int mask = 0; mask < (1 << n); mask++) {
            // If this state is unreachable, skip it.
            if (dp[mask] == Integer.MAX_VALUE) {
                continue;
            }

            // Find all courses that are ready to be taken in the current semester.
            // A course 'i' is ready if:
            // 1. It has not been taken yet (not in 'mask').
            // 2. All its prerequisites are already completed (all bits in prereq[i] are in 'mask').
            int readyToTakeMask = 0;
            for (int i = 0; i < n; i++) {
                if ((mask & (1 << i)) == 0) { // Course i is not yet taken
                    if ((prereq[i] & mask) == prereq[i]) { // All prerequisites of i are in 'mask'
                        readyToTakeMask |= (1 << i);
                    }
                }
            }

            // Now, we need to choose a subset of courses from 'readyToTakeMask' to take in this semester.
            // This subset must have at most 'k' courses.
            // Iterate through all non-empty submasks of 'readyToTakeMask'.
            // The loop `for (int submask = readyToTakeMask; submask > 0; submask = (submask - 1) & readyToTakeMask)`
            // efficiently iterates through all subsets of `readyToTakeMask`.
            for (int submask = readyToTakeMask; submask > 0; submask = (submask - 1) & readyToTakeMask) {
                // If the number of courses in 'submask' is within the limit 'k'.
                if (Integer.bitCount(submask) <= k) {
                    // Update the minimum semesters to reach the new state (mask | submask).
                    // This new state is reached by taking 'submask' courses after 'mask' courses.
                    dp[mask | submask] = Math.min(dp[mask | submask], dp[mask] + 1);
                }
            }
        }

        // The final answer is the minimum semesters to complete all 'n' courses,
        // which is represented by a mask with all 'n' bits set.
        return dp[(1 << n) - 1];
    }
}