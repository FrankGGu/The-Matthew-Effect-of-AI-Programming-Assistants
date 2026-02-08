import "math"

func minDifficulty(jobDifficulty []int, d int) int {
    n := len(jobDifficulty)

    // If it's impossible to schedule all jobs (more days than jobs), return -1.
    if n < d {
        return -1
    }

    // dp[i][j] will store the minimum difficulty to schedule the first i jobs
    // (from jobDifficulty[0] to jobDifficulty[i-1]) into j days.
    dp := make([][]int, n+1)
    for i := range dp {
        dp[i] = make([]int, d+1)
        for j := range dp[i] {
            dp[i][j] = math.MaxInt32
        }
    }

    // Base case: 0 jobs scheduled in 0 days has 0 difficulty.
    dp[0][0] = 0

    // Iterate through the number of days from 1 to d
    for day := 1; day <= d; day++ {
        // Iterate through the number of jobs considered (from 1 to n)
        // 'jobsCount' represents the number of jobs from jobDifficulty[0] to jobDifficulty[jobsCount-1]
        for jobsCount := 1; jobsCount <= n; jobsCount++ {
            // It's impossible to schedule 'jobsCount' jobs into 'day' days if jobsCount < day
            if jobsCount < day {
                continue
            }

            currentDayMaxDifficulty := 0
            // Iterate through possible split points for the current day's jobs.
            // 'prevJobsCount' is the number of jobs scheduled in 'day-1' days.
            // The jobs for the current 'day' will be from jobDifficulty[prevJobsCount] to jobDifficulty[jobsCount-1].
            // 'prevJobsCount' must be at least 'day-1' because 'day-1' jobs must be scheduled in 'day-1' days.
            // 'prevJobsCount' can go up to 'jobsCount-1' (meaning only jobDifficulty[jobsCount-1] is on the current day).
            for prevJobsCount := jobsCount - 1; prevJobsCount >= day - 1; prevJobsCount-- {
                // Calculate the maximum difficulty for the jobs on the current day.
                // These are jobs from jobDifficulty[prevJobsCount] to jobDifficulty[jobsCount-1].
                currentDayMaxDifficulty = max(currentDayMaxDifficulty, jobDifficulty[prevJobsCount])

                // If the previous state (dp[prevJobsCount][day-1]) was unreachable, skip.
                if dp[prevJobsCount][day-1] == math.MaxInt32 {
                    continue
                }

                // Update dp[jobsCount][day] with the minimum difficulty found.
                // It's the sum of the minimum difficulty for previous jobs in previous days
                // plus the maximum difficulty for jobs on the current day.
                dp[jobsCount][day] = min(dp[jobsCount][day], dp[prevJobsCount][day-1] + currentDayMaxDifficulty)
            }
        }
    }

    // The final answer is dp[n][d]. If it's still math.MaxInt32, it means it's impossible.
    if dp[n][d] == math.MaxInt32 {
        return -1
    }
    return dp[n][d]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}