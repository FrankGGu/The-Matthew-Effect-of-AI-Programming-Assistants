func minOperations(s1 string, s2 string) int {
	diff := []int{}
	for i := 0; i < len(s1); i++ {
		if s1[i] != s2[i] {
			diff = append(diff, i)
		}
	}

	if len(diff)%2 != 0 {
		return -1
	}

	n := len(diff)
	if n == 0 {
		return 0
	}

	dp := make([]int, n+1)
	for i := 1; i <= n; i++ {
		dp[i] = dp[i-1] + 1
		if i >= 2 {
			if (diff[i-1]-diff[i-2])%2 == 0 {
				dp[i] = min(dp[i], dp[i-2]+1)
			} else {
				dp[i] = min(dp[i], dp[i-2]+2)
			}
		}
	}

	return dp[n]
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}