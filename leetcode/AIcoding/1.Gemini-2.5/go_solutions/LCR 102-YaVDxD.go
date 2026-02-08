func findTargetSumWays(nums []int, target int) int {
	sum := 0
	for _, num := range nums {
		sum += num
	}

	if (target+sum)%2 != 0 || target+sum < 0 {
		return 0
	}

	targetSubsetSum := (target + sum) / 2

	dp := make([]int, targetSubsetSum+1)
	dp[0] = 1

	for _, num := range nums {
		for j := targetSubsetSum; j >= num; j-- {
			dp[j] += dp[j-num]
		}
	}

	return dp[targetSubsetSum]
}