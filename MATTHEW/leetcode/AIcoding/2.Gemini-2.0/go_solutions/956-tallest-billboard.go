func tallestBillboard(rods []int) int {
	sum := 0
	for _, rod := range rods {
		sum += rod
	}
	dp := make([]int, sum+1)
	for i := 1; i <= sum; i++ {
		dp[i] = -1
	}
	for _, rod := range rods {
		temp := make([]int, sum+1)
		copy(temp, dp)
		for i := 0; i <= sum-rod; i++ {
			if temp[i] < 0 {
				continue
			}
			dp[i+rod] = max(dp[i+rod], temp[i])
			dp[abs(i-rod)] = max(dp[abs(i-rod)], temp[i]+min(i, rod))
		}
	}
	return dp[0]
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}