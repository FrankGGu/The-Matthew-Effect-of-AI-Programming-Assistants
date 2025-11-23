func numDecodings(s string) int {
	n := len(s)
	dp := make([]int, n+1)
	dp[0] = 1
	dp[1] = ways(s[:1])
	mod := 1000000007

	for i := 2; i <= n; i++ {
		dp[i] = (dp[i-1]*ways(s[i-1:i])) % mod
		dp[i] = (dp[i] + dp[i-2]*ways(s[i-2:i])) % mod
	}

	return dp[n]
}

func ways(s string) int {
	if len(s) == 1 {
		if s == "0" {
			return 0
		} else if s == "*" {
			return 9
		} else {
			return 1
		}
	} else {
		if s == "**" {
			return 15
		} else if s[0] == '*' {
			if s[1] >= '0' && s[1] <= '6' {
				return 2
			} else {
				return 1
			}
		} else if s[1] == '*' {
			if s[0] == '1' {
				return 9
			} else if s[0] == '2' {
				return 6
			} else {
				return 0
			}
		} else {
			num, _ := strconv.Atoi(s)
			if num >= 10 && num <= 26 {
				return 1
			} else {
				return 0
			}
		}
	}
}