func numDecodings(s string) int {
	n := len(s)
	dp := make([]int, n+1)
	dp[0] = 1
	dp[1] = 1
	if s[0] == '0' {
		dp[1] = 0
	}

	for i := 2; i <= n; i++ {
		oneDigit := int(s[i-1] - '0')
		twoDigits := int((s[i-2] - '0')*10 + (s[i-1] - '0'))

		if oneDigit >= 1 && oneDigit <= 9 {
			dp[i] += dp[i-1]
		}

		if twoDigits >= 10 && twoDigits <= 26 {
			dp[i] += dp[i-2]
		}
	}

	return dp[n]
}