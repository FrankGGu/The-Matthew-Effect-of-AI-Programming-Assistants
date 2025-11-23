var maxScoreOfNonOverlappingIntervals = function(intervals) {
    // Sort intervals by their end times. This is crucial for the dynamic programming approach.
    intervals.sort((a, b) => a[1] - b[1]);

    const n = intervals.length;
    // dp[i] will store the maximum score achievable considering intervals up to index i-1.
    // dp[0] means no intervals considered, so the score is 0.
    const dp = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        const [currentStart, currentEnd, currentScore] = intervals[i - 1];

        // Option 1: Do not include the current interval.
        // The maximum score is the same as the maximum score considering intervals up to i-2.
        dp[i] = dp[i - 1];

        // Option 2: Include the current interval.
        // We need to find the latest non-overlapping interval that ends before or at currentStart.
        // This is done using binary search on the already sorted intervals.
        let low = 0;
        let high = i - 2; // Search in intervals[0 ... i-2]
        let prevCompatibleIntervalIndex = -1; // Stores the index of the latest compatible interval found

        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (intervals[mid][1] <= currentStart) {
                prevCompatibleIntervalIndex = mid;
                low = mid + 1; // This interval is compatible, try to find a later one
            } else {
                high = mid - 1; // This interval overlaps, look earlier
            }
        }

        let scoreFromPreviousCompatible = 0;
        if (prevCompatibleIntervalIndex !== -1) {
            // If a compatible interval was found, its score (and previous compatible ones)
            // is stored in dp[prevCompatibleIntervalIndex + 1].
            scoreFromPreviousCompatible = dp[prevCompatibleIntervalIndex + 1];
        }

        // Update dp[i] with the maximum of the two options:
        // 1. Excluding the current interval (dp[i-1])
        // 2. Including the current interval (currentScore + scoreFromPreviousCompatible)
        dp[i] = Math.max(dp[i], currentScore + scoreFromPreviousCompatible);
    }

    // The maximum score considering all intervals is stored in dp[n].
    return dp[n];
};