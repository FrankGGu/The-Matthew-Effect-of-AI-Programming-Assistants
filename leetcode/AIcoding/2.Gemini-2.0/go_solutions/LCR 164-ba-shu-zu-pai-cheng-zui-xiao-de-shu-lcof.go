func crackPassword(password string) int {
	n := len(password)
	dp := make([]int, n+1)
	dp[0] = 1
	for i := 1; i <= n; i++ {
		dp[i] = 0
		if password[i-1] != '0' {
			dp[i] += dp[i-1]
		}
		if i >= 2 {
			num := (int(password[i-2]-'0')*10 + int(password[i-1]-'0'))
			if num >= 10 && num <= 26 {
				dp[i] += dp[i-2]
			}
		}
	}
	return dp[n]
}