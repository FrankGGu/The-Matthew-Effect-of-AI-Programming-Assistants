func totalSteps(nums []int) int {
	n := len(nums)
	stack := []int{}
	dp := make([]int, n)
	ans := 0

	for i := n - 1; i >= 0; i-- {
		for len(stack) > 0 && nums[i] > nums[stack[len(stack)-1]] {
			dp[i] = max(dp[i]+1, dp[stack[len(stack)-1]])
			stack = stack[:len(stack)-1]
		}
		stack = append(stack, i)
		ans = max(ans, dp[i])
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}