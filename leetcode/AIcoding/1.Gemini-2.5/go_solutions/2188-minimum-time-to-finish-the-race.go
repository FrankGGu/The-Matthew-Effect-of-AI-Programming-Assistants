package main

import (
	"container/list"
	"math"
)

func minTime(tires [][]int, changeTime int, numLaps int) int64 {
	const MAX_K_SEGMENT = 65 // Max number of consecutive laps to precompute for any tire.
	// This constant is chosen to be large enough to cover all cases where r > 1
	// without int64 overflow, as f * r^(k-1) grows very fast.
	// For r=2, f=1, 2^62 is ~4.6 * 10^18, which is close to math.MaxInt64.
	// So k up to 63-64 is the max before overflow. 65 is a safe upper bound.

	// minConsecutiveTimes[k] stores the minimum total time to complete 'k' laps
	// consecutively using a single tire, for k from 1 to MAX_K_SEGMENT.
	minConsecutiveTimes := make([]int64, MAX_K_SEGMENT+1)
	for i := range minConsecutiveTimes {
		minConsecutiveTimes[i] = math.MaxInt64
	}
	// minConsecutiveTimes[0] is conceptually 0, but not directly used in DP for segment times.

	minFR1 := math.MaxInt64 // Minimum initial lap time (f) for tires with r = 1

	for _, tire := range tires {
		f := int64(tire[0])
		r := int64(tire[1])

		if r == 1 {
			minFR1 = min(minFR1, f)
			// For r=1, a single lap takes 'f'. Update minConsecutiveTimes[1].
			minConsecutiveTimes[1] = min(minConsecutiveTimes[1], f)
		} else {
			currentLapTime := f
			totalTimeForKLaps := f
			minConsecutiveTimes[1] = min(minConsecutiveTimes[1], f)

			for k := 2; k <= MAX_K_SEGMENT; k++ {
				// Check for overflow before multiplication
				if currentLapTime > math.MaxInt64/r {
					break
				}
				currentLapTime *= r

				// Check for overflow before addition
				if totalTimeForKLaps > math.MaxInt64-currentLapTime {
					break
				}
				totalTimeForKLaps += currentLapTime

				minConsecutiveTimes[k] = min(minConsecutiveTimes[k], totalTimeForKLaps)

				// Optimization: if the current lap time is very high, it's generally
				// better to change tires than to continue with this rapidly degrading tire.
				// A safe upper bound for `changeTime + min_f_val` is roughly 2 * 10^5.
				// If `currentLapTime` exceeds a threshold (e.g., 3 * 10^5),
				// it's unlikely to be optimal to continue for more laps with this tire.
				if currentLapTime > 300000 {
					break
				}
			}
		}
	}

	dp := make([]int64, numLaps+1)
	dp[0] = 0 // 0 time for 0 laps
	for i := 1; i <= numLaps; i++ {
		dp[i] = math.MaxInt64
	}

	// Monotonic queue for optimizing the case where the last segment uses an r=1 tire
	// for more than MAX_K_SEGMENT laps.
	// Stores indices `j` such that `dp[j] - minFR1 * j` is minimal.
	dq := list.New() // Stores int (index j)

	for i := 1; i <= numLaps; i++ {
		// Case 1: The last segment of 'k' laps uses a tire, where k <= MAX_K_SEGMENT.
		// This covers both r=1 and r>1 tires for short segments.
		for k := 1; k <= int(min(int64(i), MAX_K_SEGMENT)); k++ {
			segmentTime := minConsecutiveTimes[k]
			if segmentTime == math.MaxInt64 {
				continue // No tire can complete 'k' laps without overflow
			}

			prevIdx := i - k
			prevTime := dp[prevIdx]
			if prevTime == math.MaxInt64 {
				continue // Cannot reach prevIdx laps
			}

			currentTotal := prevTime + segmentTime
			if prevIdx > 0 { // If it's not the very first segment, a tire change occurred
				currentTotal += int64(changeTime)
			}
			dp[i] = min(dp[i], currentTotal)
		}

		// Case 2: The last segment of 'k' laps uses an r=1 tire, where k > MAX_K_SEGMENT.
		// This means k = i - j, where j is the previous state (number of laps completed).
		// dp[i] = dp[j] + changeTime + minFR1 * (i-j)
		// We want to minimize (dp[j] - minFR1 * j) + minFR1 * i + changeTime.
		// The `j` values we consider are such that `k = i-j > MAX_K_SEGMENT`,
		// which implies `j < i - MAX_K_SEGMENT`.
		if minFR1 != math.MaxInt64 {
			// Add `j_candidate = i - (MAX_K_SEGMENT + 1)` to the deque if valid.
			// This `j_candidate` is the largest `j` that satisfies `j < i - MAX_K_SEGMENT`.
			jCandidate := i - (MAX_K_SEGMENT + 1)
			if jCandidate >= 0 && dp[jCandidate] != math.MaxInt64 {
				valToAdd := dp[jCandidate] - minFR1*int64(jCandidate)
				for dq.Len() > 0 {
					backJ := dq.Back().Value.(int)
					backVal := dp[backJ] - minFR1*int64(backJ)
					if backVal >= valToAdd {
						dq.Remove(dq.Back())
					} else {
						break
					}
				}
				dq.PushBack(jCandidate)
			}

			// Remove elements from the front of the deque if they are too old.
			// An index `j` is too old if `i - j <= MAX_K_SEGMENT`,
			// which means `j >= i - MAX_K_SEGMENT`.
			// So, remove `j` from the front if `j` is no longer valid for a "long segment".
			for dq.Len() > 0 {
				frontJ := dq.Front().Value.(int)
				if frontJ >= i-MAX_K_SEGMENT {
					dq.Remove(dq.Front())
				} else {
					break
				}
			}

			// Query the minimum from the deque
			if dq.Len() > 0 {
				bestJ := dq.Front().Value.(int)
				currentTotalR1LongSegment := (dp[bestJ] - minFR1*int64(bestJ)) + minFR1*int64(i)
				if bestJ > 0 { // If it's not the very first segment, a tire change occurred
					currentTotalR1LongSegment += int64(changeTime)
				}
				dp[i] = min(dp[i], currentTotalR1LongSegment)
			}
		}
	}

	return dp[numLaps]
}

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}