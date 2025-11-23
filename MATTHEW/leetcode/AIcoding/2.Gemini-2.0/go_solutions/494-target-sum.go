func findTargetSumWays(nums []int, target int) int {
	sum := 0
	for _, num := range nums {
		sum += num
	}
	if (sum+target)%2 != 0 {
		return 0
	}
	newTarget := (sum + target) / 2
	if newTarget < 0 {
		return 0
	}

	dp := make([]int, newTarget+1)
	dp[0] = 1

	for _, num := range nums {
		for i := newTarget; i >= num; i-- {
			dp[i] += dp[i-num]
		}
	}

	return dp[newTarget]
}