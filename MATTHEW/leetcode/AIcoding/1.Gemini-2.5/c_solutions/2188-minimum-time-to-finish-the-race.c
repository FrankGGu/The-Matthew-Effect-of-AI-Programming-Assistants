#include <stdlib.h> // For malloc, free
#include <limits.h> // For LLONG_MAX

long long min(long long a, long long b) {
    return a < b ? a : b;
}

#define MAX_K_SINGLE_TIRE 65

long long minimumFinishTime(int** tires, int tiresSize, int* tiresColSize, int numLaps, int changeTime) {
    // minTimeForKLapsWithAnyCar[k] stores the minimum time to complete 'k' laps
    // using a single car's tire (without switching cars during these 'k' laps).
    // Initialize with LLONG_MAX to find minimums.
    long long minTimeForKLapsWithAnyCar[MAX_K_SINGLE_TIRE + 1];
    for (int k = 1; k <= MAX_K_SINGLE_TIRE; ++k) {
        minTimeForKLapsWithAnyCar[k] = LLONG_MAX;
    }

    // Precompute minTimeForKLapsWithAnyCar for each car
    for (int i = 0; i < tiresSize; ++i) {
        long long fi = tires[i][0];
        long long ri = tires[i][1];

        long long current_total_time_for_this_tire = 0;
        long long power_ri = 1; // Represents ri^(k-1) for the k-th lap

        for (int k = 1; k <= MAX_K_SINGLE_TIRE; ++k) {
            // Calculate time for the k-th lap: fi * ri^(k-1)
            // Check for overflow before multiplication (fi * power_ri)
            if (power_ri > LLONG_MAX / fi) {
                // fi * power_ri would overflow, subsequent terms will also be too large.
                break;
            }
            long long time_for_this_lap = fi * power_ri;

            // Check for overflow before adding to total time (current_total_time_for_this_tire + time_for_this_lap)
            if (current_total_time_for_this_tire > LLONG_MAX - time_for_this_lap) {
                // current_total_time_for_this_tire would overflow, subsequent terms will also be too large.
                break;
            }
            current_total_time_for_this_tire += time_for_this_lap;

            // Update the minimum time for 'k' laps using any single tire
            minTimeForKLapsWithAnyCar[k] = min(minTimeForKLapsWithAnyCar[k], current_total_time_for_this_tire);

            // Prepare power_ri for the next lap (k+1)
            if (k < MAX_K_SINGLE_TIRE) { // Only update if we need it for the next iteration
                // Check for overflow before multiplication (power_ri * ri)
                if (ri > 1 && power_ri > LLONG_MAX / ri) {
                    // power_ri * ri would overflow, subsequent terms will also be too large.
                    break;
                }
                power_ri *= ri;
            }
            // If ri == 1, power_ri remains 1, no overflow possible here.
        }
    }

    // dp[i] stores the minimum time to finish 'i' laps
    long long* dp = (long long*)malloc((numLaps + 1) * sizeof(long long));
    if (dp == NULL) {
        // Handle allocation error, though LeetCode usually guarantees success
        return -1; 
    }

    dp[0] = 0; // 0 time for 0 laps

    for (int i = 1; i <= numLaps; ++i) {
        dp[i] = LLONG_MAX; // Initialize with max value

        // Iterate over 'k', the number of laps completed by the last car segment.
        // 'k' can range from 1 up to 'i' laps, but is capped by MAX_K_SINGLE_TIRE
        // because longer segments with a single tire are generally not optimal.
        int k_limit = (i < MAX_K_SINGLE_TIRE) ? i : MAX_K_SINGLE_TIRE;
        for (int k = 1; k <= k_limit; ++k) {
            if (minTimeForKLapsWithAnyCar[k] == LLONG_MAX) {
                continue; // This 'k' laps segment is not possible or too expensive
            }

            long long prev_dp_val = dp[i-k];
            if (prev_dp_val == LLONG_MAX) {
                continue; // Cannot reach i-k laps
            }

            long long current_segment_time = minTimeForKLapsWithAnyCar[k];
            long long total_time_for_this_path;

            if (i - k == 0) { // This means k == i, and it's the first (and only) segment of laps
                total_time_for_this_path = current_segment_time;
            } else { // Not the first segment, so add changeTime for switching cars
                // Check for overflow for prev_dp_val + changeTime
                if (prev_dp_val > LLONG_MAX - changeTime) {
                    continue; // Path too expensive, skip this option
                }
                long long time_after_prev_segment = prev_dp_val + changeTime;

                // Check for overflow for time_after_prev_segment + current_segment_time
                if (time_after_prev_segment > LLONG_MAX - current_segment_time) {
                    continue; // Path too expensive, skip this option
                }
                total_time_for_this_path = time_after_prev_segment + current_segment_time;
            }
            dp[i] = min(dp[i], total_time_for_this_path);
        }
    }

    long long result = dp[numLaps];
    free(dp); // Clean up allocated memory
    return result;
}