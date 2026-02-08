import (
	"sort"
)

func minTotalDistance(robots []int, factories [][]int) int64 {
	sort.Ints(robots)

	n := len(robots)
	m := len(factories)

	dp := make([][]int64, n+1)
	for i := range dp {
		dp[i] = make([]int64, m+1)
		for j := range dp[i] {
			dp[i][j] = -1
		}
	}

	var solve func(int, int) int64
	solve = func(robotIndex int, factoryIndex int) int64 {
		if robotIndex == n {
			return 0
		}
		if factoryIndex == m {
			return 1e18
		}

		if dp[robotIndex][factoryIndex] != -1 {
			return dp[robotIndex][factoryIndex]
		}

		res := solve(robotIndex, factoryIndex+1)

		cost := int64(0)
		taken := 0
		for i := robotIndex; i < n && taken < factories[factoryIndex][1]; i++ {
			cost += int64(abs(robots[i] - factories[factoryIndex][0]))
			taken++
			res = min(res, cost+solve(i+1, factoryIndex+1))
		}

		dp[robotIndex][factoryIndex] = res
		return res
	}

	result := solve(0, 0)
	return result
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}