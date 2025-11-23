func maxJumps(arr []int, d int) int {
	n := len(arr)
	dp := make([]int, n)
	for i := range dp {
		dp[i] = -1
	}

	var dfs func(int) int
	dfs = func(i int) int {
		if dp[i] != -1 {
			return dp[i]
		}

		maxJump := 1
		for j := i - 1; j >= max(0, i-d); j-- {
			if arr[j] >= arr[i] {
				break
			}
			maxJump = max(maxJump, dfs(j)+1)
		}

		for j := i + 1; j <= min(n-1, i+d); j++ {
			if arr[j] >= arr[i] {
				break
			}
			maxJump = max(maxJump, dfs(j)+1)
		}

		dp[i] = maxJump
		return maxJump
	}

	ans := 0
	for i := 0; i < n; i++ {
		ans = max(ans, dfs(i))
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}