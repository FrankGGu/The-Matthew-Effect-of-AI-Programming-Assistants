func longestSubsequence(arr []int) int {
	n := len(arr)
	if n == 0 {
		return 0
	}
	dp := make([]int, n)
	for i := 0; i < n; i++ {
		dp[i] = 1
	}
	for i := 1; i < n; i++ {
		for j := 0; j < i; j++ {
			if arr[i] < arr[j] && (arr[j]-arr[i]) == 1 {
				dp[i] = max(dp[i], dp[j]+1)
			}
		}
	}
	maxLen := 0
	for _, length := range dp {
		if length > maxLen {
			maxLen = length
		}
	}
	return maxLen
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}