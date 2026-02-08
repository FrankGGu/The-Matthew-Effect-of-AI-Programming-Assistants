func findGoodStrings(n int, s1 string, s2 string, evil string) int {
	m := len(evil)
	mod := 1000000007
	nxt := make([]int, m+1)
	for i := 1; i < m; i++ {
		j := nxt[i-1]
		for j > 0 && evil[i] != evil[j] {
			j = nxt[j-1]
		}
		if evil[i] == evil[j] {
			j++
		}
		nxt[i] = j
	}

	dp := make([][][][]int, n+1)
	for i := range dp {
		dp[i] = make([][][]int, m+1)
		for j := range dp[i] {
			dp[i][j] = make([][]int, 2)
			for k := range dp[i][j] {
				dp[i][j][k] = make([]int, 2)
				for l := range dp[i][j][k] {
					dp[i][j][k][l] = -1
				}
			}
		}
	}

	var solve func(int, int, int, int) int
	solve = func(idx int, match int, lbound int, rbound int) int {
		if match == m {
			return 0
		}
		if idx == n {
			return 1
		}
		if dp[idx][match][lbound][rbound] != -1 {
			return dp[idx][match][lbound][rbound]
		}

		start := 'a'
		if lbound == 1 {
			start = rune(s1[idx])
		}
		end := 'z'
		if rbound == 1 {
			end = rune(s2[idx])
		}

		ans := 0
		for char := start; char <= end; char++ {
			newMatch := match
			for newMatch > 0 && rune(evil[newMatch]) != char {
				newMatch = nxt[newMatch-1]
			}
			if rune(evil[newMatch]) == char {
				newMatch++
			}

			newLbound := 0
			if lbound == 1 && char == start {
				newLbound = 1
			}
			newRbound := 0
			if rbound == 1 && char == end {
				newRbound = 1
			}

			ans = (ans + solve(idx+1, newMatch, newLbound, newRbound)) % mod
		}

		dp[idx][match][lbound][rbound] = ans
		return ans
	}

	return solve(0, 0, 1, 1)
}