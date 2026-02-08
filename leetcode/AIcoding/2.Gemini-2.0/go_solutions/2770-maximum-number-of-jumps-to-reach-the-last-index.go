func maxJumps(arr []int, d int) int {
	n := len(arr)
	dp := make([]int, n)
	for i := range dp {
		dp[i] = 1
	}

	indices := make([]int, n)
	for i := range indices {
		indices[i] = i
	}

	sort.Slice(indices, func(i, j int) bool {
		return arr[indices[i]] < arr[indices[j]]
	})

	for _, i := range indices {
		for j := i - 1; j >= max(0, i-d); j-- {
			if arr[j] < arr[i] {
				dp[i] = max(dp[i], dp[j]+1)
			} else {
				break
			}
		}

		for j := i + 1; j <= min(n-1, i+d); j++ {
			if arr[j] < arr[i] {
				dp[i] = max(dp[i], dp[j]+1)
			} else {
				break
			}
		}
	}

	ans := 0
	for _, v := range dp {
		ans = max(ans, v)
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