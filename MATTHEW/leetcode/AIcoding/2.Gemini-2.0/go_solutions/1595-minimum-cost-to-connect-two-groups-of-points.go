import "math"

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func minCostConnectTwoGroups(cost [][]int) int {
	n1 := len(cost)
	n2 := len(cost[0])

	dp := make([]int, 1<<n2)
	for i := 1; i < (1 << n2); i++ {
		dp[i] = math.MaxInt32
	}

	for i := 0; i < n1; i++ {
		newDp := make([]int, 1<<n2)
		for j := 1; j < (1 << n2); j++ {
			newDp[j] = math.MaxInt32
		}

		for mask := 0; mask < (1 << n2); mask++ {
			for k := 0; k < n2; k++ {
				if (mask & (1 << k)) > 0 {
					newDp[mask] = min(newDp[mask], dp[mask^(1<<k)]+cost[i][k])
					newDp[mask] = min(newDp[mask], dp[mask]+cost[i][k])
				}
			}
		}

		dp = newDp
	}

	return dp[(1<<n2)-1]
}