func minimumOperations(x int, y int) int {
	if x <= y {
		return y - x
	}

	dp := make(map[int]int)

	var solve func(int) int
	solve = func(curr int) int {
		if curr <= y {
			return y - curr
		}

		if val, ok := dp[curr]; ok {
			return val
		}

		res := curr - y

		res = min(res, 1+solve(curr%5)+curr/5)
		res = min(res, 1+solve((curr+5-curr%5)%5)+curr/5+1)

		res = min(res, 1+solve(curr%10)+curr/10)
		res = min(res, 1+solve((curr+10-curr%10)%10)+curr/10+1)

		dp[curr] = res
		return res
	}

	return solve(x)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}