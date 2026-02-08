func countSpecialNumbers(n int) int {
	s := []int{}
	for x := n; x > 0; x /= 10 {
		s = append(s, x%10)
	}
	reverse(s)
	m := len(s)
	memo := make([][]int, m)
	for i := range memo {
		memo[i] = make([]int, 1<<10)
		for j := range memo[i] {
			memo[i][j] = -1
		}
	}
	var dfs func(int, bool, bool, int) int
	dfs = func(i int, isLimit bool, isNum bool, mask int) int {
		if i == m {
			if isNum {
				return 1
			}
			return 0
		}
		if !isLimit && isNum && memo[i][mask] != -1 {
			return memo[i][mask]
		}
		up := 9
		if isLimit {
			up = s[i]
		}
		ans := 0
		if !isNum {
			ans += dfs(i+1, false, false, mask)
		}
		start := 1
		if isNum {
			start = 0
		}
		for d := start; d <= up; d++ {
			if (mask>>d)&1 == 0 {
				ans += dfs(i+1, isLimit && d == up, true, mask|(1<<d))
			}
		}
		if !isLimit && isNum {
			memo[i][mask] = ans
		}
		return ans
	}
	res := dfs(0, true, false, 0)
	return n - res
}

func reverse(a []int) {
	for i, j := 0, len(a)-1; i < j; i, j = i+1, j-1 {
		a[i], a[j] = a[j], a[i]
	}
}