func countSubIslands(grid1 [][]int, grid2 [][]int) int {
	rows := len(grid1)
	cols := len(grid1[0])

	count := 0

	var dfs func(r, c int) bool
	dfs = func(r, c int) bool {
		if r < 0 || r >= rows || c < 0 || c >= cols || grid2[r][c] == 0 {
			return true
		}

		isCurrentCellSub := (grid1[r][c] == 1)

		grid2[r][c] = 0

		isSubIsland := isCurrentCellSub
		isSubIsland = isSubIsland && dfs(r+1, c)
		isSubIsland = isSubIsland && dfs(r-1, c)
		isSubIsland = isSubIsland && dfs(r, c+1)
		isSubIsland = isSubIsland && dfs(r, c-1)

		return isSubIsland
	}

	for r := 0; r < rows; r++ {
		for c := 0; c < cols; c++ {
			if grid2[r][c] == 1 {
				if dfs(r, c) {
					count++
				}
			}
		}
	}

	return count
}