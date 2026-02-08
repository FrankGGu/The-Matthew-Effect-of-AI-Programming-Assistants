func countPaths(grid [][]int, xor int) int {
	m, n := len(grid), len(grid[0])
	count := 0
	var dfs func(int, int, int)
	dfs = func(i, j, currentXor int) {
		if i == m || j == n {
			return
		}
		currentXor ^= grid[i][j]
		if i == m-1 && j == n-1 {
			if currentXor == xor {
				count++
			}
			return
		}
		dfs(i+1, j, currentXor)
		dfs(i, j+1, currentXor)
	}
	dfs(0, 0, 0)
	return count
}