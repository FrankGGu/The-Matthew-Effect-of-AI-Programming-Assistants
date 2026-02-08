func isOriginal(s1 string, s2 string) bool {
	m, n := len(s1), len(s2)
	dp := make([][]int, m+1)
	for i := range dp {
		dp[i] = make([]int, n+1)
		for j := range dp[i] {
			dp[i][j] = -1
		}
	}

	var solve func(i, j int) int
	solve = func(i, j int) int {
		if i == m && j == n {
			return 1
		}
		if dp[i][j] != -1 {
			return dp[i][j]
		}

		res := 0
		// Try to decode s1
		if i < m && s1[i] == '0' {
			// Invalid
		} else if i < m {
			num := 0
			for k := i; k < m && k < i+3; k++ {
				num = num*10 + int(s1[k]-'0')
				if num > 0 && num <= 200 {
					numStr := string(s1[i : k+1])
					lenNumStr := len(numStr)

					// Try to match s2
					if j+lenNumStr <= n && s1[i:k+1] == s2[j:j+lenNumStr] {
						res |= solve(k+1, j+lenNumStr)
						if res == 1 {
							break
						}
					}
				}
			}
		}

		// Try to decode s2
		if j < n && s2[j] == '0' {
			// Invalid
		} else if j < n {
			num := 0
			for k := j; k < n && k < j+3; k++ {
				num = num*10 + int(s2[k]-'0')
				if num > 0 && num <= 200 {
					numStr := string(s2[j : k+1])
					lenNumStr := len(numStr)

					// Try to match s1
					if i+lenNumStr <= m && s2[j:k+1] == s1[i:i+lenNumStr] {
						res |= solve(i+lenNumStr, k+1)
						if res == 1 {
							break
						}
					}
				}
			}
		}

		dp[i][j] = res
		return res
	}

	return solve(0, 0) == 1
}