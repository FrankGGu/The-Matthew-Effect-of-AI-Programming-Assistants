func constrainedSubsetSum(nums []int, k int) int {
	n := len(nums)
	dp := make([]int, n)
	for i := range dp {
		dp[i] = nums[i]
	}
	maxSum := nums[0]
	queue := []int{}

	for i := 0; i < n; i++ {
		if len(queue) > 0 {
			dp[i] = max(dp[i], dp[queue[0]]+nums[i])
		}
		maxSum = max(maxSum, dp[i])

		for len(queue) > 0 && dp[queue[len(queue)-1]] <= dp[i] {
			queue = queue[:len(queue)-1]
		}
		queue = append(queue, i)

		if queue[0] == i-k {
			queue = queue[1:]
		}
	}

	return maxSum
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}