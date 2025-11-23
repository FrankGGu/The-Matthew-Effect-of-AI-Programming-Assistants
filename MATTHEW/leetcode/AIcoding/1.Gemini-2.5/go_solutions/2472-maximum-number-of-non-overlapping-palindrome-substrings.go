package main

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxPalindromes(s string, k int) int {
	n := len(s)

	isPalindrome := make([][]bool, n)
	for i := range isPalindrome {
		isPalindrome[i] = make([]bool, n)
	}

	for i := 0; i < n; i++ {
		isPalindrome[i][i] = true
	}

	for length := 2; length <= n; length++ {
		for i := 0; i <= n-length; i++ {
			j := i + length - 1
			if s[i] == s[j] {
				if length == 2 {
					isPalindrome[i][j] = true
				} else {
					isPalindrome[i][j] = isPalindrome[i+1][j-1]
				}
			}
		}
	}

	dp := make([]int, n+1)

	for i := 1; i <= n; i++ {
		dp[i] = dp[i-1]

		for j := i - k; j >= 0; j-- {
			if isPalindrome[j][i-1] {
				dp[i] = max(dp[i], dp[j]+1)
			}
		}
	}

	return dp[n]
}