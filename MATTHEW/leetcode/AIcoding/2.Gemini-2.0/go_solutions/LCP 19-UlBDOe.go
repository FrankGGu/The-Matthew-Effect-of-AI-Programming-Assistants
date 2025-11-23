import "math"

func minimumOperations(leaves string) int {
	n := len(leaves)
	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, 3)
	}

	dp[0][0] = 0
	if leaves[0] == 'y' {
		dp[0][0] = 1
	}
	dp[0][1] = math.MaxInt32
	dp[0][2] = math.MaxInt32

	for i := 1; i < n; i++ {
		if leaves[i] == 'r' {
			dp[i][0] = dp[i-1][0] + 1
		} else {
			dp[i][0] = dp[i-1][0]
		}

		dp[i][1] = math.MaxInt32
		if leaves[i] == 'y' {
			dp[i][1] = min(dp[i-1][0], dp[i-1][1]) + 1
		} else {
			dp[i][1] = min(dp[i-1][0], dp[i-1][1])
		}

		dp[i][2] = math.MaxInt32
		if leaves[i] == 'r' {
			dp[i][2] = min(dp[i-1][1], dp[i-1][2])
		} else {
			dp[i][2] = min(dp[i-1][1], dp[i-1][2]) + 1
		}
	}

	return dp[n-1][2]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}