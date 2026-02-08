func minIncrements(n int, cost []int) int {
	ans := 0
	var dfs func(int) int
	dfs = func(i int) int {
		if i > n {
			return 0
		}
		left := dfs(2 * i)
		right := dfs(2*i + 1)
		ans += abs(left - right)
		return max(left, right) + cost[i-1]
	}
	dfs(1)
	return ans
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}