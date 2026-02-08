import java.util.Arrays;

class Solution {
    public int minSkips(int[] dist, int speed, double hoursBefore) {
        int n = dist.length;
        // dp[j] stores the minimum total distance (numerator) to cover 'i' segments using 'j' skips.
        // The actual time is dp[j] / speed.
        // We use long to avoid double precision issues and represent time as (total_distance_numerator / speed).
        // The maximum possible total_distance_numerator can be up to n * max_dist * speed (roughly 10^5 * 10^5 * 10^5 = 10^15),
        // which fits within a long (approx 9 * 10^18).
        long[] dp = new long[n + 1];

        // Initialize dp array with a very large value representing infinity.
        Arrays.fill(dp, Long.MAX_VALUE);

        // Base case: 0 segments covered, 0 skips, 0 total distance.
        dp[0] = 0L;

        // Iterate through each segment (from 1-based index 1 to n)
        for (int i = 1; i <= n; i++) {
            long current_segment_dist = dist[i - 1];

            // Iterate through possible number of skips 'j' from 'i' down to 0.
            // Iterating backwards ensures that when calculating dp[j] for the current 'i',
            // dp[j] and dp[j-1] refer to values from the previous 'i-1' iteration.
            for (int j = i; j >= 0; j--) {
                long val_no_skip = Long.MAX_VALUE;
                if (dp[j] != Long.MAX_VALUE) { // Case: Don't skip the wait after the (i-1)-th segment.
                                                // This means 'j' skips were used for the first 'i-1' segments.
                    long prev_total_numerator = dp[j];
                    long current_total_numerator = prev_total_numerator + current_segment_dist;

                    if (i < n) { // If it's not the last segment, we must wait (round up to the next integer hour).
                        // Calculate ceil(current_total_numerator / speed) * speed
                        // Using integer division: ceil(X/Y) = (X + Y - 1) / Y for positive integers X, Y.
                        // Then multiply by speed to get the new numerator.
                        val_no_skip = ((current_total_numerator + speed - 1) / speed) * speed;
                    } else { // It's the last segment, no waiting required after it.
                        val_no_skip = current_total_numerator;
                    }
                }

                long val_with_skip = Long.MAX_VALUE;
                if (j > 0 && dp[j - 1] != Long.MAX_VALUE) { // Case: Skip the wait after the (i-1)-th segment.
                                                             // This means 'j-1' skips were used for the first 'i-1' segments.
                    long prev_total_numerator = dp[j - 1];
                    long current_total_numerator = prev_total_numerator + current_segment_dist;
                    // No ceil operation as we are skipping the wait.
                    val_with_skip = current_total_numerator;
                }

                // Update dp[j] with the minimum of the two options
                dp[j] = Math.min(val_no_skip, val_with_skip);
            }
        }

        // After processing all segments, find the minimum number of skips 'j'
        // such that the total time (dp[j] / speed) is less than or equal to hoursBefore.
        for (int j = 0; j <= n; j++) {
            if (dp[j] != Long.MAX_VALUE) {
                // Compare the calculated total time with hoursBefore.
                if ((double) dp[j] / speed <= hoursBefore) {
                    return j;
                }
            }
        }

        return -1; // No solution found
    }
}