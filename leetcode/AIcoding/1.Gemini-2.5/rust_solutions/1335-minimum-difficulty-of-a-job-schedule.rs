impl Solution {
    pub fn min_difficulty(job_difficulty: Vec<i32>, d: i32) -> i32 {
        let n = job_difficulty.len();
        let d_usize = d as usize;

        if n < d_usize {
            return -1;
        }

        // dp[day_count][jobs_count]
        // dp[j][i] = minimum difficulty to schedule jobs 0..i-1 into j days.
        // j: number of days (1 to d_usize)
        // i: number of jobs considered (1 to n)
        let mut dp = vec![vec![usize::MAX; n + 1]; d_usize + 1];

        // Base case for j=1 (first day)
        // dp[1][i] = max difficulty of jobs 0..i-1
        let mut current_max_difficulty = 0;
        for i in 1..=n {
            current_max_difficulty = current_max_difficulty.max(job_difficulty[i - 1]);
            dp[1][i] = current_max_difficulty as usize;
        }

        // Fill dp table for j days (from 2 to d_usize)
        for j in 2..=d_usize {
            // For each number of jobs i (from j to n)
            // i must be at least j (cannot schedule fewer jobs than days)
            for i in j..=n {
                let mut max_difficulty_segment = 0; // Max difficulty for the jobs on the current day
                // `split_idx` represents the number of jobs assigned to previous `j-1` days.
                // So, jobs from `0` to `split_idx-1` are scheduled in `j-1` days,
                // and jobs from `split_idx` to `i-1` are scheduled on the current `j`-th day.
                // We need `dp[j-1][split_idx]`.
                // `split_idx` must be at least `j-1` (to schedule `j-1` jobs in `j-1` days).
                // `split_idx` must be less than `i` (the current day must have at least one job).
                // Iterate `split_idx` from `i-1` down to `j-1` to efficiently calculate `max_difficulty_segment`.
                for split_idx in (j - 1..i).rev() {
                    // `job_difficulty[split_idx]` is the first job of the current day's segment (jobs split_idx to i-1).
                    max_difficulty_segment = max_difficulty_segment.max(job_difficulty[split_idx]);

                    if dp[j-1][split_idx] != usize::MAX {
                        dp[j][i] = dp[j][i].min(dp[j-1][split_idx] + max_difficulty_segment as usize);
                    }
                }
            }
        }

        if dp[d_usize][n] == usize::MAX {
            -1
        } else {
            dp[d_usize][n] as i32
        }
    }
}