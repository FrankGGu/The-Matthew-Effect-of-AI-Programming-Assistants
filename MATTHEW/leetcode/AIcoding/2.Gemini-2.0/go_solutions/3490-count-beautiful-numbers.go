func countBeautifulNumbers(n int64) int {
	s := string(n)
	l := len(s)
	dp := make([][1 << 5]int, l+1)
	for i := range dp {
		for j := range dp[i] {
			dp[i][j] = -1
		}
	}

	var solve func(int, int, bool) int
	solve = func(idx int, mask int, tight bool) int {
		if idx == l {
			return 1
		}
		if !tight && dp[idx][mask] != -1 {
			return dp[idx][mask]
		}

		up := 9
		if tight {
			up = int(s[idx] - '0')
		}

		ans := 0
		for dig := 0; dig <= up; dig++ {
			newMask := mask
			if idx%2 == 0 {
				if dig == 2 || dig == 3 || dig == 5 || dig == 7 {
					continue
				}
			} else {
				if dig == 0 || dig == 1 || dig == 4 || dig == 6 || dig == 8 || dig == 9 {
					continue
				}
			}
			newTight := tight && (dig == up)
			ans += solve(idx+1, newMask, newTight)
		}

		if !tight {
			dp[idx][mask] = ans
		}
		return ans
	}

	return solve(0, 0, true)
}

func string(n int64) string {
	if n == 0 {
		return "0"
	}

	var result []byte
	for n > 0 {
		digit := n % 10
		result = append([]byte{byte('0' + digit)}, result...)
		n /= 10
	}

	return string(result)
}