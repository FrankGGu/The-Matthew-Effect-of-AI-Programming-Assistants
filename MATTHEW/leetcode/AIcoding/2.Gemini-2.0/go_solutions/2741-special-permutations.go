func specialPerm(nums []int) int {
	n := len(nums)
	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, 1<<n)
	}
	mod := 1000000007

	for i := 0; i < n; i++ {
		dp[i][1<<i] = 1
	}

	for mask := 0; mask < (1 << n); mask++ {
		for i := 0; i < n; i++ {
			if (mask & (1 << i)) > 0 {
				for j := 0; j < n; j++ {
					if (mask&(1<<j)) == 0 && (nums[i]%nums[j] == 0 || nums[j]%nums[i] == 0) {
						dp[j][mask|(1<<j)] = (dp[j][mask|(1<<j)] + dp[i][mask]) % mod
					}
				}
			}
		}
	}

	ans := 0
	for i := 0; i < n; i++ {
		ans = (ans + dp[i][(1<<n)-1]) % mod
	}

	return ans
}