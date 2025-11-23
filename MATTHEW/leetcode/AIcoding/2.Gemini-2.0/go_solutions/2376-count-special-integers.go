func countSpecialIntegers(n int) int {
	s := []int{}
	for x := n; x > 0; x /= 10 {
		s = append(s, x%10)
	}
	reverse(s)

	m := len(s)
	dp := make([][]int, m)
	for i := range dp {
		dp[i] = make([]int, 1<<10)
		for j := range dp[i] {
			dp[i][j] = -1
		}
	}

	var dfs func(int, int, bool, bool) int
	dfs = func(pos int, mask int, isLimit bool, isNum bool) int {
		if pos == m {
			if isNum {
				return 1
			}
			return 0
		}
		if !isLimit && isNum && dp[pos][mask] != -1 {
			return dp[pos][mask]
		}

		up := 9
		if isLimit {
			up = s[pos]
		}

		res := 0
		if !isNum {
			res += dfs(pos+1, mask, false, false)
		}
		for i := 1; i <= up; i++ {
			if (mask>>i)&1 == 0 {
				res += dfs(pos+1, mask|(1<<i), isLimit && i == s[pos], true)
			}
		}

		if !isLimit && isNum {
			dp[pos][mask] = res
		}
		return res
	}

	return dfs(0, 0, true, false)
}

func reverse(s []int) {
	for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
		s[i], s[j] = s[j], s[i]
	}
}