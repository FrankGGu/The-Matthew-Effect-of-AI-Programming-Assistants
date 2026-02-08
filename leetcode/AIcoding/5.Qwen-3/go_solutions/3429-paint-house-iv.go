package main

func minCostII(costs [][]int) int {
	if len(costs) == 0 || len(costs[0]) == 0 {
		return 0
	}
	n := len(costs)
	m := len(costs[0])
	dp := make([]int, m)
	for i := 0; i < n; i++ {
		nextDp := make([]int, m)
		min1 := math.MaxInt32
		min2 := math.MaxInt32
		for j := 0; j < m; j++ {
			if dp[j] < min1 {
				min2 = min1
				min1 = dp[j]
			} else if dp[j] < min2 {
				min2 = dp[j]
			}
		}
		for j := 0; j < m; j++ {
			if dp[j] == min1 {
				nextDp[j] = min2 + costs[i][j]
			} else {
				nextDp[j] = min1 + costs[i][j]
			}
		}
		dp = nextDp
	}
	minResult := math.MaxInt32
	for _, v := range dp {
		if v < minResult {
			minResult = v
		}
	}
	return minResult
}