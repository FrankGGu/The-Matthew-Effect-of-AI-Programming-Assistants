func getMaximumGold(grid [][]int) int {
	m, n := len(grid), len(grid[0])
	maxGold := 0

	var dfs func(int, int, int, map[string]bool)
	dfs = func(row, col, currentGold int, visited map[string]bool) {
		if row < 0 || row >= m || col < 0 || col >= n || grid[row][col] == 0 {
			maxGold = max(maxGold, currentGold)
			return
		}

		key := string(row) + "," + string(col)
		if visited[key] {
			maxGold = max(maxGold, currentGold)
			return
		}

		newVisited := make(map[string]bool)
		for k, v := range visited {
			newVisited[k] = v
		}
		newVisited[key] = true

		gold := grid[row][col]
		dfs(row+1, col, currentGold+gold, newVisited)
		dfs(row-1, col, currentGold+gold, newVisited)
		dfs(row, col+1, currentGold+gold, newVisited)
		dfs(row, col-1, currentGold+gold, newVisited)
	}

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if grid[i][j] != 0 {
				dfs(i, j, 0, make(map[string]bool))
			}
		}
	}

	return maxGold
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}