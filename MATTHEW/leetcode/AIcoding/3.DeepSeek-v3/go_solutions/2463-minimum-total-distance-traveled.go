import (
	"sort"
)

func minimumTotalDistance(robot []int, factory [][]int) int64 {
	sort.Ints(robot)
	sort.Slice(factory, func(i, j int) bool {
		return factory[i][0] < factory[j][0]
	})

	m := len(robot)
	n := len(factory)
	dp := make([][]int64, n+1)
	for i := range dp {
		dp[i] = make([]int64, m+1)
		for j := range dp[i] {
			dp[i][j] = 1 << 60
		}
	}
	dp[0][0] = 0

	for i := 1; i <= n; i++ {
		pos, limit := factory[i-1][0], factory[i-1][1]
		dp[i][0] = 0
		for j := 1; j <= m; j++ {
			cost := int64(0)
			dp[i][j] = dp[i-1][j]
			for k := 1; k <= min(limit, j); k++ {
				cost += int64(abs(pos - robot[j-k]))
				if dp[i-1][j-k]+cost < dp[i][j] {
					dp[i][j] = dp[i-1][j-k] + cost
				}
			}
		}
	}

	return dp[n][m]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}