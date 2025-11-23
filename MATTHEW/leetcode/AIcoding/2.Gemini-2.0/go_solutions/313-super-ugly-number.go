func nthSuperUglyNumber(n int, primes []int) int {
	dp := make([]int, n)
	dp[0] = 1
	k := len(primes)
	pointers := make([]int, k)
	nums := make([]int, k)
	for i := 0; i < k; i++ {
		nums[i] = primes[i]
	}

	for i := 1; i < n; i++ {
		minVal := nums[0]
		for j := 1; j < k; j++ {
			if nums[j] < minVal {
				minVal = nums[j]
			}
		}
		dp[i] = minVal
		for j := 0; j < k; j++ {
			if nums[j] == minVal {
				pointers[j]++
				nums[j] = dp[pointers[j]] * primes[j]
			}
		}
	}

	return dp[n-1]
}