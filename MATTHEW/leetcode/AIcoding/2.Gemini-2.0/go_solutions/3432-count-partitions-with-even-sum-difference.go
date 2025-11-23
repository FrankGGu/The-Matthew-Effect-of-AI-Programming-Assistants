func countPartitions(nums []int, k int) int {
	sum := 0
	for _, num := range nums {
		sum += num
	}

	if sum%2 != 0 {
		return 1 << len(nums)
	}

	if k > sum/2 {
		return 0
	}

	n := len(nums)
	dp := make([]int, sum/2+1)
	dp[0] = 1
	mod := int(1e9 + 7)

	for _, num := range nums {
		for j := sum / 2; j >= num; j-- {
			dp[j] = (dp[j] + dp[j-num]) % mod
		}
	}

	ans := 1
	for i := 0; i < n; i++ {
		ans = (ans * 2) % mod
	}

	invalid := (2 * dp[sum/2]) % mod
	return (ans - invalid + mod) % mod
}