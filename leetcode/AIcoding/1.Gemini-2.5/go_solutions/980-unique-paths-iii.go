func uniquePathsIII(grid [][]int) int {
	R, C := len(grid), len(grid[0])
	startR, startC := -1, -1
	walkableCells := 0 // Count of 0s and 1s

	for r := 0; r < R; r++ {
		for c := 0; c < C; c++ {
			if grid[r][c] == 1 {
				startR, startC = r, c
				walkableCells++
			} else if grid[r][c] == 0 {
				walkableCells++
			}
		}
	}

	var dfs func(r, c, cellsToVisit int) int
	dfs = func(r, c, cellsToVisit int) int {
		if r < 0 || r >= R || c < 0 || c >= C || grid[r][c] == -1 {
			return 0
		}

		if grid[r][c] == 2 {
			if cellsToVisit == 0 {
				return 1
			}
			return 0
		}

		originalVal := grid[r][c]
		grid[r][c] = -2 // Mark as visited

		pathCount := 0
		pathCount += dfs(r+1, c, cellsToVisit-1)
		pathCount += dfs(r-1, c, cellsToVisit-1)
		pathCount += dfs(r, c+1, cellsToVisit-1)
		pathCount += dfs(r, c-1, cellsToVisit-1)

		grid[r][c] = originalVal // Backtrack

		return pathCount
	}

	return dfs(startR, startC, walkableCells)
}