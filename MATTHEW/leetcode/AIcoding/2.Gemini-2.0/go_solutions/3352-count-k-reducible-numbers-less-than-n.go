func countKReducible(n int64, k int) int {
	s := int64ToString(n)
	m := len(s)
	dp := make([][]int, m+1)
	for i := range dp {
		dp[i] = make([]int, 2)
	}
	dp[0][1] = 1

	for i := 0; i < m; i++ {
		digit := int(s[i] - '0')
		for j := 0; j < 2; j++ {
			upperBound := 9
			if j == 1 {
				upperBound = digit
			}
			for d := 0; d <= upperBound; d++ {
				newBound := 0
				if j == 1 && d == digit {
					newBound = 1
				}
				if d != k {
					dp[i+1][newBound] += dp[i][j]
				}
			}
		}
	}
	return dp[m][0] + dp[m][1]
}

func int64ToString(n int64) string {
	if n == 0 {
		return "0"
	}
	s := ""
	for n > 0 {
		digit := n % 10
		s = string(rune('0'+digit)) + s
		n /= 10
	}
	return s
}