import "math"

func connectTwoGroups(cost [][]int) int {
	n := len(cost)
	m := len(cost[0])

	minCostGroup1 := make([]int, n)
	for i := 0; i < n; i++ {
		minCostGroup1[i] = math.MaxInt32
		for j := 0; j < m; j++ {
			if cost[i][j] < minCostGroup1[i] {
				minCostGroup1[i] = cost[i][j]
			}
		}
	}

	dp := make([]int, 1<<m)
	for i := 1; i < (1 << m); i++ {
		dp[i] = math.MaxInt32
	}
	// dp[0] is 0, representing no Group 2 points covered, no cost.

	for i := 0; i < n; i++ { // Iterate through each point in Group 1
		nextDp := make([]int, 1<<m)
		for k := 0; k < (1 << m); k++ {
			nextDp[k] = math.MaxInt32
		}

		for mask := 0; mask < (1 << m); mask++ { // Iterate through previous masks
			if dp[mask] == math.MaxInt32 {
				continue
			}

			// Option 1: Connect Group 1 point 'i' to a Group 2 point 'j' that is NOT yet in 'mask'.
			// This updates 'mask' and ensures 'i' is connected.
			for j := 0; j < m; j++ {
				newMask := mask | (1 << j)
				if dp[mask]+cost[i][j] < nextDp[newMask] {
					nextDp[newMask] = dp[mask] + cost[i][j]
				}
			}

			// Option 2: Connect Group 1 point 'i' to a Group 2 point 'j' that IS already in 'mask'.
			// This ensures 'i' is connected, but 'mask' does not change.
			// We add the minimum cost for 'i' to connect to *any* Group 2 point.
			// This covers the case where 'i' connects only to already covered Group 2 points.
			if dp[mask]+minCostGroup1[i] < nextDp[mask] {
				nextDp[mask] = dp[mask] + minCostGroup1[i]
			}
		}
		dp = nextDp
	}

	return dp[(1<<m)-1]
}