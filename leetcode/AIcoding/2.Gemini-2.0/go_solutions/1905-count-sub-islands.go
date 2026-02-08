func countSubIslands(grid1 [][]int, grid2 [][]int) int {
	m, n := len(grid1), len(grid1[0])
	count := 0

	var dfs func(i, j int) bool
	dfs = func(i, j int) bool {
		if i < 0 || i >= m || j < 0 || j >= n || grid2[i][j] == 0 {
			return true
		}
		if grid1[i][j] == 0 {
			return false
		}

		grid2[i][j] = 0

		up := dfs(i-1, j)
		down := dfs(i+1, j)
		left := dfs(i, j-1)
		right := dfs(i, j+1)

		return up && down && left && right
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if grid2[i][j] == 1 {
				if dfs(i, j) {
					count++
				}
			}
		}
	}

	return count
}