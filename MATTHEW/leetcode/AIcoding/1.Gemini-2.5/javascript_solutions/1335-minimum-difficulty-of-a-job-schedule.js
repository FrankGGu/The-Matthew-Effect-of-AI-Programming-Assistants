var minDifficulty = function(jobDifficulty, d) {
    const n = jobDifficulty.length;

    // If the number of days is greater than the number of jobs,
    // it's impossible to schedule, as each day must have at least one job.
    if (d > n) {
        return -1;
    }

    // dp[k][i] will store the minimum difficulty to schedule the first `i` jobs
    // (from index 0 to i-1) into `k` days.
    // k ranges from 1 to d.
    // i ranges from 1 to n.
    // Initialize with Infinity, as we are looking for a minimum.
    const dp = Array(d + 1).fill(0).map(() => Array(n + 1).fill(Infinity));

    // Base case for k = 1 (scheduling jobs into a single day)
    // For the first day, the difficulty is the maximum difficulty among all jobs
    // scheduled on that day.
    let currentMaxDifficulty = 0;
    for (let i = 1; i <= n; i++) {
        // jobDifficulty[i-1] corresponds to the i-th job (0-indexed)
        currentMaxDifficulty = Math.max(currentMaxDifficulty, jobDifficulty[i - 1]);
        dp[1][i] = currentMaxDifficulty;
    }

    // Fill the dp table for k days, from 2 up to d
    for (let k = 2; k <= d; k++) {
        // i represents the total number of jobs considered so far (from 0 to i-1).
        // To schedule `i` jobs into `k` days, we must have at least `k` jobs.
        for (let i = k; i <= n; i++) {
            // To calculate dp[k][i], we consider all possible ways to split the jobs
            // for the k-th day.
            // Jobs from index `p` to `i-1` are scheduled on the k-th day.
            // Jobs from index `0` to `p-1` are scheduled in `k-1` days.
            // `p` represents the number of jobs scheduled in the first `k-1` days.
            // `p` must be at least `k-1` (minimum jobs for `k-1` days).
            // `p` must be at most `i-1` (leaving at least one job for the k-th day).

            let maxDifficultyForCurrentDay = 0;
            // Iterate backwards from the last job of the current day (i-1)
            // to the first possible job of the current day (`k-1` because `p` is the count of previous jobs)
            for (let p = i - 1; p >= k - 1; p--) {
                // jobDifficulty[p] is the current job being added to the k-th day's schedule.
                // maxDifficultyForCurrentDay accumulates the maximum difficulty for jobs from index `p` to `i-1`.
                maxDifficultyForCurrentDay = Math.max(maxDifficultyForCurrentDay, jobDifficulty[p]);

                // If the previous state (dp[k-1][p]) is reachable (not Infinity)
                if (dp[k - 1][p] !== Infinity) {
                    // Update dp[k][i] with the minimum possible difficulty
                    // (difficulty of previous k-1 days + difficulty of current day's jobs)
                    dp[k][i] = Math.min(dp[k][i], dp[k - 1][p] + maxDifficultyForCurrentDay);
                }
            }
        }
    }

    // The result is the minimum difficulty to schedule all `n` jobs into `d` days.
    return dp[d][n];
};