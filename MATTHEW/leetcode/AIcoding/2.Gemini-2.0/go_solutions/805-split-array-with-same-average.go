func splitArraySameAverage(nums []int) bool {
	n := len(nums)
	if n <= 1 {
		return false
	}

	sum := 0
	for _, num := range nums {
		sum += num
	}

	for i := 1; i < n; i++ {
		if (sum*i)%n == 0 {
			target := (sum * i) / n
			if canPartition(nums, i, target) {
				return true
			}
		}
	}

	return false
}

func canPartition(nums []int, k int, target int) bool {
	n := len(nums)
	dp := make([][]bool, k+1)
	for i := range dp {
		dp[i] = make([]bool, target+1)
	}

	dp[0][0] = true

	for _, num := range nums {
		for i := k; i >= 1; i-- {
			for j := target; j >= num; j-- {
				dp[i][j] = dp[i][j] || dp[i-1][j-num]
			}
		}
	}

	return dp[k][target]
}