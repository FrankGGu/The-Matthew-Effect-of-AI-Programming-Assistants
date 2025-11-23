package main

import (
	"math"
)

func minSkips(dist []int, speed int, hours float64) int {
	n := len(dist)

	// dp[j] stores the minimum time to travel all segments processed so far using exactly j skips.
	// The size is n+1 because we can use up to n skips (one for each segment).
	dp := make([]float64, n+1)
	for i := 0; i <= n; i++ {
		dp[i] = math.MaxFloat64
	}
	dp[0] = 0.0 // Base case: 0 segments, 0 skips, 0 time

	for i := 0; i < n; i++ { // Iterate through each segment (dist[i] is the (i+1)-th segment)
		segmentTime := float64(dist[i]) / float64(speed)

		// We are calculating dp values for (i+1) segments.
		// The number of skips 'j' can range from 0 to (i+1).
		// Iterate 'j' downwards to ensure dp[j-1] refers to the value from the previous outer loop iteration
		// (i.e., time for 'i' segments with 'j-1' skips) before it's overwritten.
		for j := i + 1; j >= 0; j-- {
			// Option 1: Don't skip the waiting period after the previous segment (dist[i-1]).
			// This means 'j' skips were used for the first 'i' segments, and 'j' skips are used for the first (i+1) segments.
			// dp[j] (from the previous outer loop iteration) holds the minimum time for the first 'i' segments using 'j' skips.
			timeIfNoSkip := math.MaxFloat64
			if dp[j] != math.MaxFloat64 {
				prevTotalTime := dp[j]
				if i < n-1 { // If this is not the last segment, we must round up the total time
					prevTotalTime = math.Ceil(dp[j])
				}
				timeIfNoSkip = prevTotalTime + segmentTime
			}

			// Option 2: Skip the waiting period after the previous segment (dist[i-1]).
			// This means 'j-1' skips were used for the first 'i' segments, and 'j' skips are used for the first (i+1) segments.
			// This option requires 'j' to be greater than 0.
			timeIfSkip := math.MaxFloat64
			if j > 0 && dp[j-1] != math.MaxFloat64 {
				timeIfSkip = dp[j-1] + segmentTime
			}

			dp[j] = math.Min(timeIfNoSkip, timeIfSkip)
		}
	}

	// After processing all 'n' segments, dp[j] contains the minimum time to travel all 'n' segments using exactly 'j' skips.
	// Find the minimum 'j' such that dp[j] <= hours.
	for j := 0; j <= n; j++ {
		// Use a small epsilon for float comparison due to potential precision issues.
		if dp[j] <= hours+1e-9 {
			return j
		}
	}

	return -1 // Not possible to reach the meeting on time within 'hours'
}