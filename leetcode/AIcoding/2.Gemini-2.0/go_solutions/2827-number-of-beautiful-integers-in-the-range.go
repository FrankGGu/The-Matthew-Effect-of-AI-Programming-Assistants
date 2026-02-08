func numberOfBeautifulIntegers(n int, k int) int {
	s := fmt.Sprintf("%d", n)
	l := len(s)
	dp := make([][][][2]int, l+1)
	for i := range dp {
		dp[i] = make([][][][2]int, k+1)
		for j := range dp[i] {
			dp[i][j] = make([][2]int, 2)
			for m := range dp[i][j] {
				dp[i][j][m] = [2]int{-1, -1}
			}
		}
	}

	var dfs func(int, int, int, bool) int
	dfs = func(pos int, rem int, evenCnt int, isLimit bool) int {
		if pos == l {
			if rem == 0 && evenCnt == l/2 {
				return 1
			}
			return 0
		}

		if dp[pos][rem][evenCnt][boolToInt(isLimit)] != -1 {
			return dp[pos][rem][evenCnt][boolToInt(isLimit)]
		}

		up := 9
		if isLimit {
			up = int(s[pos] - '0')
		}

		ans := 0
		for i := 0; i <= up; i++ {
			newRem := (rem*10 + i) % k
			newEvenCnt := evenCnt
			if i%2 == 0 {
				newEvenCnt++
			}
			ans += dfs(pos+1, newRem, newEvenCnt, isLimit && i == up)
		}

		dp[pos][rem][evenCnt][boolToInt(isLimit)] = ans
		return ans
	}

	return dfs(0, 0, 0, true)
}

func boolToInt(b bool) int {
	if b {
		return 1
	}
	return 0
}