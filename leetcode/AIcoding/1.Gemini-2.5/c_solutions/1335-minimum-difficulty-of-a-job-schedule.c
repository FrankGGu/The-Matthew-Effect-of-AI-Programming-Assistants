#include <limits.h>
#include <string.h> // For memset

static inline int max(int a, int b) {
    return a > b ? a : b;
}

int minDifficulty(int* jobDifficulty, int jobDifficultySize, int d) {
    int n = jobDifficultySize;

    // If it's impossible to schedule at least one job per day
    if (n < d) {
        return -1;
    }

    // dp[i][j] will store the minimum difficulty to schedule the first 'i' jobs into 'j' days.
    // i ranges from 0 to n (number of jobs)
    // j ranges from 0 to d (number of days)
    int dp[n + 1][d + 1];

    // Initialize dp table with a large value representing infinity.
    // 0x3f3f3f3f is a common value for "infinity" in competitive programming,
    // as it's approximately INT_MAX / 2, which helps prevent overflow when adding.
    memset(dp, 0x3f, sizeof(dp));

    // Base case: 0 jobs scheduled into 0 days has 0 difficulty.
    dp[0][0] = 0;

    // Iterate through days from 1 to d
    for (int j = 1; j <= d; j++) {
        // Iterate through jobs from 'j' to 'n'.
        // We need at least 'j' jobs to schedule into 'j' days.
        for (int i = j; i <= n; i++) {
            int currentMaxDifficulty = 0;
            // Iterate backwards from the current job `i-1` to find the split point `k_idx`.
            // `k_idx` represents the starting index of jobs for the current day `j`.
            // The jobs for day `j` are from `jobDifficulty[k_idx]` to `jobDifficulty[i-1]`.
            // The previous `j-1` days must have scheduled jobs from `0` to `k_idx-1`.
            // So, we need to look at `dp[k_idx][j-1]`.
            // `k_idx` must be at least `j-1` because `j-1` days need at least `j-1` jobs.
            for (int k_idx = i - 1; k_idx >= j - 1; k_idx--) {
                // Calculate the maximum difficulty for the jobs assigned to the current day `j`.
                // As `k_idx` decreases, the range `[k_idx, i-1]` expands to the left,
                // so `currentMaxDifficulty` will be the max in this expanding range.
                currentMaxDifficulty = max(currentMaxDifficulty, jobDifficulty[k_idx]);

                // If the previous state `dp[k_idx][j-1]` is reachable (not infinity)
                if (dp[k_idx][j - 1] != 0x3f3f3f3f) {
                    // Update `dp[i][j]` with the minimum difficulty.
                    // It's the difficulty of scheduling `k_idx` jobs into `j-1` days
                    // plus the difficulty of scheduling jobs from `k_idx` to `i-1` into the `j`-th day.
                    if (dp[k_idx][j - 1] + currentMaxDifficulty < dp[i][j]) {
                        dp[i][j] = dp[k_idx][j - 1] + currentMaxDifficulty;
                    }
                }
            }
        }
    }

    // The result is the minimum difficulty to schedule all `n` jobs into `d` days.
    // If `dp[n][d]` is still infinity, it means it's impossible, but we've already handled `n < d`.
    // So it should be a valid value.
    return dp[n][d];
}