import java.util.Arrays;

class Solution {
    public int minSessions(int[] tasks, int sessionTime) {
        int n = tasks.length;

        // Precompute sum of task durations for each mask (subset of tasks)
        // sum[mask] will store the total duration of tasks represented by 'mask'.
        // This is done efficiently using bit manipulation:
        // sum[mask] = sum[mask_without_least_significant_bit] + duration_of_least_significant_task
        int[] sum = new int[1 << n];
        for (int mask = 1; mask < (1 << n); mask++) {
            int lsb = mask & (-mask); // Get the least significant bit (e.g., 0110 -> 0010)
            int taskIdx = Integer.numberOfTrailingZeros(lsb); // Get the index of that task (e.g., 0010 -> 1)
            sum[mask] = sum[mask ^ lsb] + tasks[taskIdx];
        }

        // dp[mask] stores the minimum number of sessions required to complete tasks represented by 'mask'.
        // Initialize with a large value (infinity) to find minimums.
        int[] dp = new int[1 << n];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0; // 0 sessions are needed for 0 tasks.

        // Iterate through all possible masks (subsets of tasks) from 1 to (1 << n) - 1.
        for (int mask = 1; mask < (1 << n); mask++) {
            // Iterate over all submasks of the current 'mask'.
            // 'submask' represents a subset of tasks that have already been scheduled.
            // 'complement_submask = mask ^ submask' represents the remaining tasks that will form a new session.
            for (int submask = mask; submask > 0; submask = (submask - 1) & mask) {
                int complement_submask = mask ^ submask;

                // Check if the tasks in 'complement_submask' can fit into a single session.
                if (sum[complement_submask] <= sessionTime) {
                    // If the 'submask' state is reachable (i.e., not MAX_VALUE),
                    // we can potentially update dp[mask].
                    if (dp[submask] != Integer.MAX_VALUE) {
                        // The number of sessions for 'mask' would be
                        // (sessions for 'submask' + 1 for the new session 'complement_submask').
                        dp[mask] = Math.min(dp[mask], dp[submask] + 1);
                    }
                }
            }
        }

        // The result is the minimum number of sessions for the mask representing all tasks.
        return dp[(1 << n) - 1];
    }
}