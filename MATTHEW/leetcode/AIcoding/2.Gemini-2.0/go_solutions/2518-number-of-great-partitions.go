func countPartitions(nums []int, k int) int {
	n := len(nums)
	sum := 0
	for _, num := range nums {
		sum += num
	}

	if sum < 2*k {
		return 0
	}

	dp := make([]int, k)
	dp[0] = 1
	mod := 1000000007

	for _, num := range nums {
		for i := k - 1; i >= num; i-- {
			dp[i] = (dp[i] + dp[i-num]) % mod
		}
	}

	less := 0
	for i := 0; i < k; i++ {
		less = (less + dp[i]) % mod
	}

	total := 1
	for i := 0; i < n; i++ {
		total = (total * 2) % mod
	}

	ans := (total - 2*less + mod*2) % mod
	return ans
}