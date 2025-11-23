func minCostClimbingStairs(cost []int) int {
	n := len(cost)

	prev2 := 0
	prev1 := 0

	for i := 2; i <= n; i++ {
		curr := min(prev1+cost[i-1], prev2+cost[i-2])
		prev2 = prev1
		prev1 = curr
	}

	return prev1
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}