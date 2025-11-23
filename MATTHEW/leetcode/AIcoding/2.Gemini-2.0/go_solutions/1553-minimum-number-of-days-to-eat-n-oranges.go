func minDays(n int) int {
	memo := make(map[int]int)
	var dfs func(int) int
	dfs = func(n int) int {
		if n <= 1 {
			return n
		}
		if val, ok := memo[n]; ok {
			return val
		}
		days := min(n%2+1+dfs(n/2), n%3+1+dfs(n/3))
		memo[n] = days
		return days
	}
	return dfs(n)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}