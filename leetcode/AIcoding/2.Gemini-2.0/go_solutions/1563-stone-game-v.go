func stoneGameV(stoneValue []int) int {
	n := len(stoneValue)
	prefixSum := make([]int, n+1)
	for i := 1; i <= n; i++ {
		prefixSum[i] = prefixSum[i-1] + stoneValue[i-1]
	}

	dp := make([][]int, n)
	for i := range dp {
		dp[i] = make([]int, n)
	}

	var solve func(int, int) int
	solve = func(i, j int) int {
		if i == j {
			return 0
		}
		if dp[i][j] != 0 {
			return dp[i][j]
		}

		res := 0
		for k := i; k < j; k++ {
			leftSum := prefixSum[k+1] - prefixSum[i]
			rightSum := prefixSum[j+1] - prefixSum[k+1]
			if leftSum < rightSum {
				res = max(res, leftSum+solve(i, k))
			} else if leftSum > rightSum {
				res = max(res, rightSum+solve(k+1, j))
			} else {
				res = max(res, leftSum+max(solve(i, k), solve(k+1, j)))
			}
		}
		dp[i][j] = res
		return res
	}

	return solve(0, n-1)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}