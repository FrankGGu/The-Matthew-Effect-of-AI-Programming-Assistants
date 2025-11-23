func restoreTheArray(s string, k int) int {
	n := len(s)
	dp := make([]int, n+1)
	mod := 1_000_000_007

	dp[n] = 1

	for i := n - 1; i >= 0; i-- {
		if s[i] == '0' {
			continue
		}

		currentNum := int64(0)
		for j := i; j < n; j++ {
			digit := int64(s[j] - '0')
			currentNum = currentNum*10 + digit

			if currentNum > int64(k) {
				break
			}

			dp[i] = (dp[i] + dp[j+1]) % mod
		}
	}

	return dp[0]
}