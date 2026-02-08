func minSessions(tasks []int, sessionTime int) int {
    n := len(tasks)
    maxMask := 1 << n

    // dp[mask] stores the minimum number of sessions required to complete tasks represented by 'mask'.
    // Initialize with a value larger than any possible number of sessions (n is the maximum possible sessions).
    dp := make([]int, maxMask)
    for i := 0; i < maxMask; i++ {
        dp[i] = n + 1 // Represents infinity
    }
    dp[0] = 0 // 0 sessions are needed for no tasks

    // sessionSum[mask] stores the total duration of tasks represented by 'mask'.
    sessionSum := make([]int, maxMask)

    // Precompute the sum of task durations for all possible masks.
    for i := 0; i < maxMask; i++ {
        for j := 0; j < n; j++ {
            if (i>>j)&1 == 1 { // If task 'j' is in the current mask 'i'
                sessionSum[i] += tasks[j]
            }
        }
    }

    // Iterate through all possible masks from 1 to maxMask-1.
    // Each mask represents a set of tasks that need to be completed.
    for mask := 1; mask < maxMask; mask++ {
        // Find the index of the first (lowest indexed) task in the current 'mask'.
        // This task must be included in the current session being formed.
        // This optimization ensures that each 'dp[mask]' state is computed based on a unique partitioning,
        // preventing redundant calculations.
        firstTaskIdx := 0
        for ; firstTaskIdx < n; firstTaskIdx++ {
            if (mask>>firstTaskIdx)&1 == 1 {
                break
            }
        }

        // Iterate through all submasks 'sub' of the current 'mask'.
        // 'sub' represents the tasks that will be completed in the *last* session.
        // We only consider submasks that include 'firstTaskIdx' to ensure uniqueness.
        for sub := mask; sub > 0; sub = (sub - 1) & mask {
            // If 'sub' does not contain 'firstTaskIdx', skip it.
            // This means 'firstTaskIdx' would have been part of an earlier session,
            // which would have been covered when processing a smaller 'mask'.
            if (sub>>firstTaskIdx)&1 == 0 {
                continue
            }

            // Check if the tasks in 'sub' can form a valid single session.
            if sessionSum[sub] <= sessionTime {
                // If valid, we can complete tasks in 'sub' in 1 session.
                // The remaining tasks are 'mask ^ sub'.
                // We update dp[mask] with the minimum sessions needed:
                // 1 (for the current session 'sub') + dp[mask ^ sub] (for remaining tasks).
                dp[mask] = min(dp[mask], 1+dp[mask^sub])
            }
        }
    }

    // The result is the minimum sessions needed to complete all tasks (represented by maxMask - 1).
    return dp[maxMask-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}