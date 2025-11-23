func isLongPressedName(name string, typed string) bool {
	i, j := 0, 0
	for j < len(typed) {
		if i < len(name) && name[i] == typed[j] {
			i++
			j++
		} else if j > 0 && typed[j] == typed[j-1] {
			j++
		} else {
			return false
		}
	}
	return i == len(name)
}

func possiblyEquals(s1 string, s2 string) bool {
	n1, n2 := len(s1), len(s2)
	dp := make([][][]bool, n1+1)
	for i := 0; i <= n1; i++ {
		dp[i] = make([][]bool, n2+1)
		for j := 0; j <= n2; j++ {
			dp[i][j] = make([]bool, 2001)
		}
	}
	dp[0][0][1000] = true

	var isDigit = func(c byte) bool {
		return c >= '0' && c <= '9'
	}

	for i := 0; i <= n1; i++ {
		for j := 0; j <= n2; j++ {
			for k := 0; k <= 2000; k++ {
				if !dp[i][j][k] {
					continue
				}

				if i < n1 && j < n2 && k == 1000 && s1[i] == s2[j] {
					dp[i+1][j+1][k] = true
				}

				if i < n1 && !isDigit(s1[i]) && k > 0 {
					dp[i+1][j][k-1] = true
				}

				if j < n2 && !isDigit(s2[j]) && k < 2000 {
					dp[i][j+1][k+1] = true
				}

				num1 := 0
				for l := i; l < n1 && l < i+3 && isDigit(s1[l]); l++ {
					num1 = num1*10 + int(s1[l]-'0')
					dp[l+1][j][k+num1-1000] = true
				}

				num2 := 0
				for l := j; l < n2 && l < j+3 && isDigit(s2[l]); l++ {
					num2 = num2*10 + int(s2[l]-'0')
					dp[i][l+1][k-num2+1000] = true
				}
			}
		}
	}

	return dp[n1][n2][1000]
}