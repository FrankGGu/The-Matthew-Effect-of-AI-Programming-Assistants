func findTargetSumWays(nums []int, target int) int {
	sum := 0
	for _, num := range nums {
		sum += num
	}

	if (sum+target)%2 != 0 || abs(target) > sum {
		return 0
	}

	capacity := (sum + target) / 2
	dp := make([]int, capacity+1)
	dp[0] = 1

	for _, num := range nums {
		for j := capacity; j >= num; j-- {
			dp[j] += dp[j-num]
		}
	}

	return dp[capacity]
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}