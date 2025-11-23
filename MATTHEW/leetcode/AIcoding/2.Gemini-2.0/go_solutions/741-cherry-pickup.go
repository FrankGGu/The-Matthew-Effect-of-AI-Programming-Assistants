import "fmt"

func cherryPickup(grid [][]int) int {
	n := len(grid)
	dp := make([][][]int, n)
	for i := range dp {
		dp[i] = make([][]int, n)
		for j := range dp[i] {
			dp[i][j] = make([]int, n)
			for k := range dp[i][j] {
				dp[i][j][k] = -1
			}
		}
	}

	var solve func(r1, c1, c2 int) int
	solve = func(r1, c1, c2 int) int {
		r2 := r1 + c1 - c2
		if r1 >= n || c1 >= n || r2 >= n || c2 >= n || grid[r1][c1] == -1 || grid[r2][c2] == -1 {
			return -1
		}

		if dp[r1][c1][c2] != -1 {
			return dp[r1][c1][c2]
		}

		if r1 == n-1 && c1 == n-1 {
			dp[r1][c1][c2] = grid[r1][c1]
			return dp[r1][c1][c2]
		}

		ans := -1
		temp := solve(r1+1, c1, c2)
		if temp != -1 {
			ans = max(ans, temp)
		}
		temp = solve(r1+1, c1, c2+1)
		if temp != -1 {
			ans = max(ans, temp)
		}
		temp = solve(r1, c1+1, c2)
		if temp != -1 {
			ans = max(ans, temp)
		}
		temp = solve(r1, c1+1, c2+1)
		if temp != -1 {
			ans = max(ans, temp)
		}

		if ans != -1 {
			ans += grid[r1][c1]
			if r1 != r2 || c1 != c2 {
				ans += grid[r2][c2]
			}
		}

		dp[r1][c1][c2] = ans
		return dp[r1][c1][c2]
	}

	result := solve(0, 0, 0)
	if result < 0 {
		return 0
	}
	return result
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}