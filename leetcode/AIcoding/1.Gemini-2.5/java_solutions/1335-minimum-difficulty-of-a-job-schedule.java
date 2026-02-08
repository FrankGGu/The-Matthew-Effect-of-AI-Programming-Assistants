class Solution {
    public int minDifficulty(int[] jobDifficulty, int d) {
        int n = jobDifficulty.length;

        // If it's impossible to schedule all jobs (more days than jobs)
        if (n < d) {
            return -1;
        }

        // dp[i][j] will store the minimum difficulty to schedule the first j jobs
        // (jobs from index 0 to j-1) into i days.
        // Using 1-based indexing for days (i) and jobs count (j).
        // dp[day][jobs_count]
        int[][] dp = new int[d + 1][n + 1];

        // Initialize dp table with a large value representing infinity
        for (int i = 0; i <= d; i++) {
            for (int j = 0; j <= n; j++) {
                dp[i][j] = Integer.MAX_VALUE;
            }
        }

        // Base case: For the first day (d=1)
        // dp[1][j] is the maximum difficulty among the first j jobs.
        int currentMaxDifficulty = 0;
        for (int j = 1; j <= n; j++) {
            currentMaxDifficulty = Math.max(currentMaxDifficulty, jobDifficulty[j - 1]);
            dp[1][j] = currentMaxDifficulty;
        }

        // Fill dp table for d days
        for (int i = 2; i <= d; i++) { // Iterate through days
            // For 'i' days, we need at least 'i' jobs.
            // So, 'j' (number of jobs) starts from 'i'.
            for (int j = i; j <= n; j++) { // Iterate through number of jobs
                // To calculate dp[i][j], we consider assigning jobs from index 'k' to 'j-1'
                // to the current day 'i'.
                // The remaining jobs (0 to k-1) must have been scheduled in 'i-1' days.
                // 'k' represents the starting index of jobs for the current day.
                // So, 'k' goes from 'j-1' down to 'i-1'.
                // If jobs k to j-1 are on day i, then jobs 0 to k-1 are on day i-1.
                // We need at least i-1 jobs for i-1 days, so k-1 >= i-1, meaning k >= i.
                // However, the loop for k should be `k` from `j-1` down to `i-1`.
                // If `k = i-1`, then `k-1 = i-2`. `dp[i-1][i-1]` would mean `i-1` jobs in `i-1` days.
                // Let's use `k` as the count of jobs already scheduled in `i-1` days.
                // So jobs `0` to `k-1` are in `i-1` days.
                // Jobs `k` to `j-1` are in the current day `i`.
                // `k` can range from `i-1` (meaning `i-1` jobs in `i-1` days, 1 job for current day)
                // to `j-1` (meaning `j-1` jobs in `i-1` days, 1 job for current day).

                int maxDifficultyToday = 0;
                // k_idx is the 0-indexed start of jobs for the current day.
                // So jobs jobDifficulty[k_idx] to jobDifficulty[j-1] are for current day.
                // Jobs jobDifficulty[0] to jobDifficulty[k_idx-1] are for previous days.
                for (int k_idx = j - 1; k_idx >= i - 1; k_idx--) {
                    maxDifficultyToday = Math.max(maxDifficultyToday, jobDifficulty[k_idx]);
                    if (dp[i - 1][k_idx] != Integer.MAX_VALUE) { // Ensure previous state was reachable
                        dp[i][j] = Math.min(dp[i][j], dp[i - 1][k_idx] + maxDifficultyToday);
                    }
                }
            }
        }

        return dp[d][n];
    }
}