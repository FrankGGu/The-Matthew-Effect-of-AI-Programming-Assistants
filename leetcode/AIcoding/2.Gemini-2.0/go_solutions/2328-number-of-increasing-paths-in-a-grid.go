func countPaths(grid [][]int) int {
	m, n := len(grid), len(grid[0])
	dp := make([][]int, m)
	for i := range dp {
		dp[i] = make([]int, n)
		for j := range dp[i] {
			dp[i][j] = -1
		}
	}
	mod := 1000000007
	ans := 0
	var dfs func(int, int) int
	dfs = func(i, j int) int {
		if dp[i][j] != -1 {
			return dp[i][j]
		}
		dp[i][j] = 1
		dirs := [][]int{{0, 1}, {0, -1}, {1, 0}, {-1, 0}}
		for _, dir := range dirs {
			x, y := i+dir[0], j+dir[1]
			if x >= 0 && x < m && y >= 0 && y < n && grid[x][y] > grid[i][j] {
				dp[i][j] = (dp[i][j] + dfs(x, y)) % mod
			}
		}
		return dp[i][j]
	}
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			ans = (ans + dfs(i, j)) % mod
		}
	}
	return ans
}