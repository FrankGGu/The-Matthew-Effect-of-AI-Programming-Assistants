import java.util.Arrays;

class Solution {
    public long minimumFinishTime(int[][] cars, int races) {
        // MAX_CONSECUTIVE_LAPS is the maximum number of consecutive laps a single car might be used.
        // The time for j consecutive laps with a car is cost + time * (2^j - 1).
        // The term time * (2^j - 1) grows exponentially.
        // If time * (2^j - 1) becomes very large (e.g., comparable to or larger than Long.MAX_VALUE),
        // or if it's much larger than the cost of starting a new car, it's better to switch.
        // The maximum cost is 10^9, minimum time is 1. log2(10^9) is approximately 29.89.
        // So, considering up to 30-32 consecutive laps is usually sufficient.
        // Using 32 (or 35 for extra safety) is a common choice for such problems.
        final int MAX_CONSECUTIVE_LAPS = 32; 

        // minTimeForConsecutiveLaps[j] stores the minimum total time to complete 'j' consecutive laps
        // using any single car, starting fresh. This includes the initial cost of the car.
        // Initialize with Long.MAX_VALUE to find minimums.
        long[] minTimeForConsecutiveLaps = new long[MAX_CONSECUTIVE_LAPS + 1];
        Arrays.fill(minTimeForConsecutiveLaps, Long.MAX_VALUE);

        // Precompute minTimeForConsecutiveLaps for j from 1 to MAX_CONSECUTIVE_LAPS
        for (int[] car : cars) {
            long cost = car[0];
            long time = car[1];

            // currentLapTimeMultiplier represents 2^(k-1) for the k-th consecutive lap.
            // It starts at 1 (for 2^0, the first lap).
            long currentLapTimeMultiplier = 1; 

            // accumulatedTimeForLaps stores the sum of time * 2^(k-1) for k=1 to j.
            long accumulatedTimeForLaps = 0; 

            for (int j = 1; j <= MAX_CONSECUTIVE_LAPS; j++) {
                // Calculate the time for the j-th consecutive lap: time * 2^(j-1)
                // Check for overflow before multiplication.
                if (time > Long.MAX_VALUE / currentLapTimeMultiplier) {
                    // The time contribution for this many laps will overflow. Break.
                    break; 
                }
                long lapTime = time * currentLapTimeMultiplier;

                // Add the current lap's time to the accumulated time for this car.
                // Check for overflow before addition.
                if (accumulatedTimeForLaps > Long.MAX_VALUE - lapTime) {
                    // Accumulated time for laps will overflow. Break.
                    break;
                }
                accumulatedTimeForLaps += lapTime;

                // Calculate the total time for this car for 'j' consecutive laps: cost + accumulatedTimeForLaps.
                // Check for overflow before addition.
                if (cost > Long.MAX_VALUE - accumulatedTimeForLaps) {
                    // Total time for this car for 'j' laps will overflow. Break.
                    break;
                }
                long totalTimeForCarForJLaps = cost + accumulatedTimeForLaps;

                // Update the minimum time for 'j' consecutive laps.
                minTimeForConsecutiveLaps[j] = Math.min(minTimeForConsecutiveLaps[j], totalTimeForCarForJLaps);

                // Prepare currentLapTimeMultiplier for the next lap (j+1) by doubling it.
                // Check for overflow before multiplication.
                if (currentLapTimeMultiplier > Long.MAX_VALUE / 2) {
                    // Multiplier for the next lap would overflow. Break.
                    break;
                }
                currentLapTimeMultiplier *= 2;
            }
        }

        // dp[i] will store the minimum time to finish 'i' races.
        // Initialize with Long.MAX_VALUE, except dp[0] = 0 (0 time for 0 races).
        long[] dp = new long[races + 1];
        Arrays.fill(dp, Long.MAX_VALUE);
        dp[0] = 0; 

        // Fill the dp table using the precomputed minTimeForConsecutiveLaps.
        // dp[i] = min(dp[i-j] + minTimeForConsecutiveLaps[j]) for j from 1 to min(i, MAX_CONSECUTIVE_LAPS).
        for (int i = 1; i <= races; i++) {
            for (int j = 1; j <= MAX_CONSECUTIVE_LAPS; j++) {
                // If i - j is negative, we cannot complete 'j' laps from a previous state.
                if (i - j < 0) {
                    break; 
                }

                // Only consider valid previous states (not Long.MAX_VALUE) and valid consecutive lap times.
                if (dp[i - j] != Long.MAX_VALUE && minTimeForConsecutiveLaps[j] != Long.MAX_VALUE) {
                    // Check for overflow before adding dp[i - j] and minTimeForConsecutiveLaps[j].
                    // If the sum would overflow, it's effectively infinity and won't be a minimum.
                    if (dp[i - j] > Long.MAX_VALUE - minTimeForConsecutiveLaps[j]) {
                        // Sum would overflow, so skip this combination.
                    } else {
                        dp[i] = Math.min(dp[i], dp[i - j] + minTimeForConsecutiveLaps[j]);
                    }
                }
            }
        }

        return dp[races];
    }
}