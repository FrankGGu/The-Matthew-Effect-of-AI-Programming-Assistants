func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxNonOverlapping(s string, k int) int {
	n := len(s)
	dp := make([]int, n+1)
	isPalindrome := make([][]bool, n)
	for i := range isPalindrome {
		isPalindrome[i] = make([]bool, n)
	}

	for i := 0; i < n; i++ {
		isPalindrome[i][i] = true
	}

	for i := 0; i < n-1; i++ {
		if s[i] == s[i+1] {
			isPalindrome[i][i+1] = true
		}
	}

	for l := 3; l <= n; l++ {
		for i := 0; i <= n-l; i++ {
			j := i + l - 1
			if s[i] == s[j] && isPalindrome[i+1][j-1] {
				isPalindrome[i][j] = true
			}
		}
	}

	for i := 1; i <= n; i++ {
		dp[i] = dp[i-1]
		for j := 0; j < i; j++ {
			if isPalindrome[j][i-1] && i-j >= k {
				dp[i] = max(dp[i], dp[j]+1)
			}
		}
	}

	return dp[n]
}