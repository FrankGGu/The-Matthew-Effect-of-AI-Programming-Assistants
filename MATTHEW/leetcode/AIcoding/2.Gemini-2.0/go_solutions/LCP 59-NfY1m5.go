import (
	"fmt"
	"sort"
)

func crossRiver(speeds []int) int {
	sort.Ints(speeds)
	n := len(speeds)
	dp := make([]int, n)
	for i := range dp {
		dp[i] = -1
	}

	var solve func(int) int
	solve = func(i int) int {
		if i < 0 {
			return 0
		}
		if dp[i] != -1 {
			return dp[i]
		}

		if i == 0 {
			dp[i] = speeds[0]
			return dp[i]
		}
		if i == 1 {
			dp[i] = speeds[1]
			return dp[i]
		}

		if i == 2 {
			dp[i] = speeds[0] + speeds[1] + speeds[2]
			return dp[i]
		}

		dp[i] = min(solve(i-1)+speeds[0]+speeds[i], solve(i-2)+speeds[1]+speeds[0]+speeds[i]+speeds[1])
		return dp[i]
	}

	return solve(n - 1)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}